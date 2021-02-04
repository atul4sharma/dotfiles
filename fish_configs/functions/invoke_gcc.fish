function invoke_gcc
    set -l std_version $argv[1]
    set -l cpp_file    $argv[2]
    set -l out_file    out.$std_version.$cpp_file

    set -l build_cpp g++ -Wall -std=c++$std_version $cpp_file -o $out_file
    echo $build_cpp
    command $build_cpp

    set -l run_outfile ./$out_file
    echo $run_outfile
    command $run_outfile
end
