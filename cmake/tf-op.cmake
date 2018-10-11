EXECUTE_PROCESS(COMMAND
                python3
                -c
                "import tensorflow as tf; print(tf.sysconfig.get_include())"
                COMMAND
                tr
                -d
                '\n'
                OUTPUT_VARIABLE
                TF_INCLUDE)

EXECUTE_PROCESS(COMMAND
                python3
                -c
                "import tensorflow as tf; print(tf.sysconfig.get_lib())"
                COMMAND
                tr
                -d
                '\n'
                OUTPUT_VARIABLE
                TF_LIB)
LINK_DIRECTORIES(${TF_LIB})

FUNCTION(ADD_TF_OP target)
    ADD_LIBRARY(${target} SHARED ${ARGN})
    TARGET_LINK_LIBRARIES(${target} tensorflow_framework)
    TARGET_INCLUDE_DIRECTORIES(${target} PRIVATE ${TF_INCLUDE})
ENDFUNCTION()
