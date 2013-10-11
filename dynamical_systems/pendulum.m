dt=0.01;        % time step
g=9.81;         % gravity
L=1.0;          % pendulum length

% initial condition
theta=0.5;      % angle
thetaPrime=0;   % angular velocity

% initialize movie
mov = avifile('pendulum.avi');

% simulation loop

for t=0:dt:5
    thetaBis=-g/L*sin(theta);
    thetaPrime=thetaPrime+dt*thetaBis;
    theta=theta+dt*thetaPrime;
    plot([0 cos(theta-pi/2)],[0 sin(theta-pi/2)]);
    xlim([-1 1]);
    ylim([-1 0]);
    xlabel('x');
    ylabel('y');
    pause(0.01);
    
    % create movie
    F = getframe(gca);
    mov=addframe(mov,F);
end

% close video file
mov=close(mov);