parameter LAYERS = 2;
parameter int LAYER_WIDTHS[LAYERS+1] = {2,1,2};

parameter int WEIGHTS [][][] = '{
    '{'{0,1}},
    '{'{1},'{2}}
};



parameter int BIASES [][] = '{
    '{0},
    '{0,0}
};
