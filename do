import dearpygui.dearpygui as dpg
import random
word = ['python', 'coding', 'pycharm', 'apple', 'eye', ]

dpg.create_context()

def game():
    valid = '1'
    def space():
        blank = []
        for i in range(len(pick)):
            blank.append('_')  # khoảng cách tương ứng với số kí tự
        return blank

    def guess():
        char = input("\nChoose a letter: ").upper()
        while (char.isalpha() is False) or (len(char) > 1):  # kiểm tra hợp lệ
            char = input("Invalid. Please choose a letter: ").upper()
        while char in lst:  # kiểm tra xem đã đoán chưa
            char = input("You have guessed this one. Please choose another letter: ").upper()
        return char

    def full():
        x = input("\nDo you want to guess the full word? Press 1 (Yes) or 0 (No): ")
        while x != '1' and x != '0':
            x = input("Invalid. Please try again: ")
        return x

    while valid == '1':
        print("-" * 50)
        pick: str = random.choice(word).upper()  # Chọn từ trong thư viện

        ans = space()
        tries = 0  # số lần sai trong khoảng cho phép

        print("The word you have to guess has", len(pick), "letters")

        lst = []
        while tries < 10:
            count = 0  # số kí tự đúng trong từ đã cho
            print("Word: ", *ans, sep='')
            letter = guess()
            lst.append(letter)

            for i in range(len(pick)):  # dò hết các kí tự của từ
                if letter == pick[i]:
                    count += 1  # đếm số lần đúng
                    ans[i] = pick[i]  # thay thế vào kết quả

            if count > 0:
                print("Correct! The word has", count, "letter(s)", letter)
                print(*ans, sep='')
            else:
                tries += 1
                print("Sorry, wrong character! You have", 10 - tries, "time(s) left")

            # nếu đoán hết rồi thì không chạy cái này nữa
            if '_' in ans:
                if full() == '1':
                    full_word = input("Guess the word: ").upper()
                    while full_word.isalpha() is False:  # kiểm tra xem có nhập toàn ký tự hay không
                        full_word = input("Invalid. Please type a WORD: ").upper()
                    if full_word == pick:
                        break
                    else:
                        tries += 1
                        print("Sorry, wrong guess! You have", 10 - tries, "time(s) left")
                print("\nLetters you have guessed:", *lst, sep=' ')
            else:
                break

        if tries == 10:
            print("\nYou lost! The word is:", pick)
        else:
            print("\nCongratulations! The word is:", pick)

        valid = input('\nDo you want to play again? Press 1 to play or 0 to exit: ')
        while valid != '1' and valid != '0':
            valid = input('Invalid. Do you want to play again? Press 1 to play or 0 to exit: ')


def subject():
    with dpg.window(tag='Subject Window', label='Subject', height=400, width=600):
        dpg.add_text('Choose a subject', pos=(190, 30))
        dpg.add_button(label='Animal', width=100, height=50, pos=(200, 60),callback= animal)
        dpg.add_button(label='Food', width=100, height=50, pos=(200, 120),callback=food)
        dpg.delete_item('Primary Window', children_only=True)


def exit_game():
    exit()

def food():
    with dpg.window(tag= 'Subject',label= 'Food', height= 400, width= 600):
        dpg.add_text("Subject: Food", pos= (200,30))
        dpg.add_text("Choose a letter:", pos=(200,0))
        dpg.add_button(label= 'Guess full word', width= 100, height= 50, pos= (200,110))
        dpg.add_text("Correct! The word has 3 letter(s): ",pos=(200,10))
        dpg.add_text("Letter(s) you have chosen: ",pos=(200,10))
        dpg.add_input_text(width= 200, height=50,pos=(0,50))
        


def animal():
    with dpg.window(tag='Subject',label= 'Animal', height= 400, width= 600):
        dpg.add_text("Subject: Animal", pos=(200,30))
        dpg.add_text("Choose a letter: ", pos=(200,0))
        dpg.add_button(label= "Guess full word", width= 100,height= 50, pos=(200,100))
        dpg.add_text("Correct! The word has 3 letter(s): ",pos= (200,10))
        dpg.add_text("Letter(s) you have chosen: ", pos=(200,10))
        dpg.add_input_text(width= 200, height= 50, pos=(200,30))
with dpg.window(tag='Primary Window'):
    dpg.add_text('HANGMAN', pos=(200, 30))

    dpg.add_button(label='Start', height=50, width=100, pos=(170, 50), callback=subject)
    dpg.add_button(label='Exit', height=50, width=100, pos=(170, 110), callback=exit_game)


dpg.create_viewport(title='HANGMAN', width=600, height=400)
dpg.setup_dearpygui()
dpg.show_viewport()
dpg.set_primary_window("Primary Window", True)
dpg.start_dearpygui()
