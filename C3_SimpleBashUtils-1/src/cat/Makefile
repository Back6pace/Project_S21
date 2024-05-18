s21_cat: s21_cat
	gcc -Wall -Werror -Wextra s21_cat.c -o s21_cat

test: s21_cat
	bash test_s21_cat.sh

clean:
	rm -rf *.o ./s21_cat

rebuild: clean s21_cat