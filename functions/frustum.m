function v = frustum(top, bot, len)
v = (len/3)*(top+bot+sqrt(top*bot));
end