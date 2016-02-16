from scheme import *
from scheme_reader import *

if __name__ == '__main__':
    env = create_global_frame()
    a = read_line('(define h (mu () x))')
    scheme_eval(a, env)
    b = read_line('(define (high fn x) (fn))')
    scheme_eval(b, env)
    expr = read_line('(high h 2)')
    print('Start!')
    scheme_eval(expr, env)
