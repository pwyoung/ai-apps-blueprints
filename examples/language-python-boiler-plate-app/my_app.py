#!/usr/bin/env python3

from urllib.request import urlretrieve
from cat2 import Cat2, Cat2Exception


def print_file(file_path):
    print(file_path)

    # line_from and line_to are optional parameters
    # cat2_file = Cat2(file_path, line_from, line_to)
    # cat2_file = Cat2(file_path)
    cat2_file = Cat2(file_path, 1, 5)

    # cat2_file is an iterator object
    for line in cat2_file:
        # print(line)
        # print(cat2_file.line_number)
        # print(cat2_file.is_bytes)
        print(f"Line #{cat2_file.line_number}: {line}")


def my_app():
    """This function downloads a file and prints it
    using pure Python.
    The code used is:
    - https://pypi.org/project/wget/
    - https://pypi.org/project/cat2/
    """
    url = "https://github.com/index.html"
    # filename = wget.download(url)
    filename = "index.html"
    urlretrieve(url, filename)
    # print("")
    # print(f"filename={filename}")
    print_file(filename)


# Call the function in this script
if __name__ == "__main__":
    my_app()
