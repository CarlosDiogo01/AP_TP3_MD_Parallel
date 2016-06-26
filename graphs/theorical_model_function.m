function [ Y ] = speedup ( movx,  n , tsetup , ts, p )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    Y =  n^2 / (((n^2./p) + ( n/p * (tsetup + ts * log (p)) )) )
end

