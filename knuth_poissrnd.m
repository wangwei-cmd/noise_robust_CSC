% Written by        J. Salmon, C.-A. Deledalle, R. Willet, Z. Harmanay
% Part of the NLPCA package at http://josephsalmon.org/code/index_codes.php?page=NLPCA
% Revision:	        01/19/2012

function k = knuth_poissrnd(lambda)

    M = size(lambda, 1);
    N = size(lambda, 2);
    k = zeros(M, N);
    L = exp(-lambda);
    for i = 1:M
        for j = 1:N
            m = 0;
            p = 1;
            stop = 0;
            while (~stop)
                m = m + 1;
                u = rand;
                p = p * u;
                stop = (p <= L(i, j));
            end
            k(i, j) = m - 1;
        end
    end