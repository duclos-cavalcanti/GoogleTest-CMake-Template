
def symlink_test_report():
    import os
    import platform
    from pathlib import Path
    
    if (not "index.html" in os.listdir()):
        p = Path("index.html")

        op_system = platform.system()

        if (op_system.lower() == "linux" or op_system.lower() == "darwin"):
            p.symlink_to("reports/test/index.html")
        elif (op.system.lower() == "windows"):
            p.symlink_to("reports\test\index.html")
        else:
            print("-- this is an unsupported operating system --")


def get_test_report():
    import os
    import platform

    op_system = platform.system()

    if (op_system.lower() == "linux" or op_system.lower() == "darwin"):
        path_html_report = "reports/test/index.html"
        os.system(f"python reports/html/gtest2html.py reports/test/index.xml {path_html_report} > /dev/null")

    elif(op_system.lower() == "windows"):
        path_html_report = "reports\test\index.html"
        os.system(f"python reports\html\gtest2html.py reports\test\index.xml {path_html_report} >> NUL")

    else:
        print("-- this is an unsupported operating system --")

def launch_test():
    import os
    from os import listdir
    import subprocess

    cwd = os.getcwd()
    path_xml_report = "reports/test/index.xml"
    for test in listdir("bin"):
        if (not test.startswith(".git")):
            os.system(f"bin/{test} --gtest_output=xml:{path_xml_report}")

def main():
    import argparse
    parser = argparse.ArgumentParser(
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.parse_args()

    parser.add_argument('-e', '--example', required=False,
                        default="ex",
                        help='Example argument to script.')

    launch_test()
    get_test_report()
    # symlink_test_report()


if __name__ == '__main__':
    main()
