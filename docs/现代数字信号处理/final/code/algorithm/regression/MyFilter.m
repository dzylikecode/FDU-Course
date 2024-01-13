function S_Out = MyFilter(S_In, model)
    S_Out = predict(model, S_In);
end