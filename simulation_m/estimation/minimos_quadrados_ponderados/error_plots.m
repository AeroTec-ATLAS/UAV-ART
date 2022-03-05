function error_plots(time, var, var_est, str) 

error_vector = (var - var_est);

figure()
subplot(2,1,1)
hold on
plot(time, var)
plot(time, var_est)
legend('Real', 'Estimated')
xlabel('Tempo [s]')
ylabel('')
title([str])

subplot(2,1,2)
plot(time, error_vector)
xlabel('Tempo [s]')
ylabel('Error')
title('Error')

end