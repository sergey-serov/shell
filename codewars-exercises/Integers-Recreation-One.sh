#!/bin/bash

## Sergey Serov
## https://www.codewars.com/kata/55aa075506463dac6600010d/discuss/shell

listSquared () {
# set -x

algorithm=1

m=$1
n=$2

result=''
typeset -i result_index=0

typeset -i current_digit=$((m - 1))

prime_numbers_m_to_n=$( eval factor {$m..$n} | awk 'NF==2{print $2}' )
set $prime_numbers_m_to_n $(( $n + 1 ))
# last number is for non ending process with 'shift' operation.

prime_numbers_for_factoring=$( factor {2..79} | awk 'NF==2{print $2}' )

# Uniq case 1
if [ $m -eq 1 ]
then
    result[$result_index]="[1, 1],"
    result_index=1
fi

# for fast calculation declaring variables inside loop as integer
typeset -i current_sum current_divisor second_divisor

while (( current_digit++ <= n )) # from m to n
do

    # Skip prime number!
    if (( current_digit == $1 ))
    then
        # sum of prime number square and 1 can not be a perfect square!
        shift
        continue # go to the next digital
    fi

    if [ $algorithm -eq 1 ]
    then

        # First way (good for small numbers)
        ###########

        # todo: understand that final sum is square based on it sums.

        # Firts of all, every number may be divisored by 1 and itself!
        (( current_sum = 1 + current_digit ** 2 ))
        current_divisor=2

        # we will gather divisors by pares, and this point where first divisors are lives
        ### area_with_small_divisors=$(bc <<< "sqrt($current_digit)")
        ### while [ $current_divisor -le $area_with_small_divisors ] # find divisors for this digit
        while (( current_divisor ** 2 < current_digit )) # find divisors for this digit
        do
            if (( current_digit % current_divisor == 0 ))
            then
                (( second_divisor = current_digit / current_divisor ))

                if (( current_divisor != second_divisor ))
                then
                    # current_sum=$(( current_sum + current_divisor ** 2 + second_divisor ** 2 ))
                    (( current_sum += current_divisor ** 2 + second_divisor ** 2 ))
                else
                    # current_sum=$(( current_sum + current_divisor ** 2 ))
                    (( current_sum += current_divisor ** 2 ))
                    break 1
                fi
            fi
            ((current_divisor++))
        done

    elif [ $algorithm -eq 2 ]
    then

        # Second way (very good for big numbers)
        ############

        current_sum=1
        # (((2^4) − 1) ÷ (2^2 − 1)) × ((3^4 − 1) ÷ (3^2 − 1)) × ((41^4 − 1) ÷ (41^2 − 1))
        for f in $(factor $current_digit)
        do

            if [ ${f: -1} = ':' ]
            then
                previous_f=0
                continue
            fi

            if [ $previous_f -eq 0 ]
            then
                previous_f=$f
                level=1
                continue
            fi

            if [ $f -eq $previous_f ]
            then
                ((level++))
            else
                current_sum=$(( (((previous_f ** (2 * level + 2)) - 1) / ( previous_f ** 2 - 1 )) * current_sum ))
                previous_f=$f
                level=1
            fi

        done

        if [ $current_sum -eq 1 ]
        then
            current_sum=$(( 1 + current_digit ** 2 )) # Prime number!
        else
            current_sum=$(( (((previous_f ** (2 * level + 2)) - 1) / ( previous_f ** 2 - 1 )) * current_sum )) # final factor
        fi

    fi

    # Final step (for both algorithms)
    ############

    # We have total sum of square divisors for this current digit here.
    # Perfect square properties:
    # 1). mod 4 = 0 || mod 4 = 1
    # 2). mod 9 = 0 || mod 3 = 1
    # 3). perfect square has even number of every factor:
    #     factor 2500: 2 2 5 5 5 5
    # 4). if last 0 -> then pre-last must be 0 too.

    if (( current_sum % 10 == 0 && current_sum % 100 != 0 ))
    then
        continue # go to the next digital
    fi

    if (( current_sum % 4 == 0 || current_sum % 4 == 1 ))
    then
        if (( current_sum % 9 == 0 || current_sum % 3 == 1 ))
        then

            # We do factoring to the first odd factor or to the end (for property #3).
            typeset -i is_perfect_square=1

            # we use only first prime numbers for optimisation -> based on development
            # expirience for perfect square it is enought.
            typeset -i reminder=$current_sum
            typeset -i possible_factor # todo is it works here?

            for possible_factor in $prime_numbers_for_factoring
            do
                factor_level=0
                while true # loop for one factor
                do
                    if (( reminder % possible_factor == 0 ))
                    then
                        (( reminder /= possible_factor ))
                        ((factor_level++))
                    else
                        # not even count of factor -> this sum is not a square!
                        if (( factor_level % 2 == 1 ))
                        then
                            break 2 # not a square
                        fi

                        break 1 # just next factor please
                    fi

                    if (( reminder == 1 ))
                    then
                        break 2 # maybe a square (will understand later)
                    fi

                    if (( possible_factor > reminder ))
                    then
                        break 2 # not a square
                    fi

                done

            done

            if (( reminder > 1 ))
            then
                is_perfect_square=0
            fi

            if (( factor_level % 2 == 1 )) # for last factor
            then
                is_perfect_square=0
            fi

            # Add to the result
            if (( is_perfect_square == 1 ))
            then
                result[$result_index]="[$current_digit, $current_sum],"
                ((result_index++))
            fi

        fi
    fi

done

# Format result
###############
result_length=$(echo -n ${result[*]} | wc -m)

if [ $result_length -eq 0 ]
then
    printf "[]" # empty result
else
    precision=$(( result_length - 1 ))
    printf "[%.${precision}s]" "$(echo ${result[*]})"
fi

# set +x
}

listSquared 1 2500


# 1, 246, 2, 123, 3, 82, 6, 41
# are the divisors of number 246.
# Squaring these divisors we get:
# 1, 60516, 4, 15129, 9, 6724, 36, 1681.
# The sum of these squares is 84100 which is
# 290 * 290.

# 1, 2, 3, 6,  41,   82,   123,   246
# 1, 4, 9, 36, 1681, 6724, 15129, 60516

# 219 f()