function invoke_gcc
    set -l std_version $argv[1]
    set -l cpp_file    $argv[2]
    set -l filename (basename $cpp_file | string split -r -m1 .)[1]
    set -l out_file    $filename.$std_version.out

    set -l build_cpp g++ -Wall $argv[3..-1] -std=c++$std_version $cpp_file -o $out_file
    echo $build_cpp
    command $build_cpp

    if test $status -eq 0
        set -l run_outfile ./$out_file
        echo $run_outfile
        command $run_outfile
    end
end
