def time(sec)
    # h, m, s = 0, 0, 0
    if sec >= 3600
        h = sec / 3600
        m = (sec % 3600) / 60
        s = (sec % 3600) % 60
    else
        h = 0
        if sec >= 60
            m = sec / 60
            s = (sec % 60) % 60
        else
            m = 0
            s = sec
        end
    end
    p "#{h}:#{m}:#{s}"
end

time(4210)
