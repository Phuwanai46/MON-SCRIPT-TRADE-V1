-- Create BY MON
-- MON SCRIPT

-- R and S

instrument {
    name = 'Support and resistance barry',
    icon = 'indicators:RSI',
    overlay = True
}

boxp=input (21, "front.newind.darvasbox.length", input.integer, 5)

input_group {
    "Support and resistance",
    top_color = input { default = "red", type = input.color },
    bottom_color = input { default = "green", type = input.color },
}

RST = boxp

RSTT = value_when(high >= highest(high, RST), high, 0)
RSTB = value_when(low <= lowest(low, RST), low, 0)
plot (RSTT, "Resistance", iff(RSTT ~= RSTT[1], na ,top_color), 4, 0, style.levels, na_mode.restart)
plot (RSTB, "support", iff(RSTB ~= RSTB[1], na ,bottom_color), 4, 0, style.levels, na_mode.restart)


  instrument {
    name = 'SMA3X5',
    short_name = 'SMA-ENG',
    icon = 'indicators:BB',
    overlay = true
}

-- SMA3

MaFast_period = input(3,"Ma Fast period",input.integer,1,1000,1)
MaFast_average = input(1,"Ma Fast average", input.string_selection,averages.titles)
MaFast_title = input(1,"Ma Fast title", input.string_selection,inputs.titles)

MaSlow_period = input(1,"Ma Slow period",input.integer,1,1000,1)
MaSlow_average = input(2,"Ma Slow average", input.string_selection,averages.titles)
MaSlow_title = input(1,"Ma Slow title", input.string_selection,inputs.titles)

MaTrend_period = input(100,"Ma Trend period",input.integer,1,1000,5)
MaTrend_average = input(2,"Ma Trend average", input.string_selection,averages.titles)
MaTrend_title = input(1,"Ma Trend title", input.string_selection,inputs.titles)

-- Create BY MON

input_group {
    "Ma Fast Line",
    colorFast = input { default = "Yellow", type = input.color },
    widthFast = input { default = 2, type = input.line_width},
    visibleFast = input { default = true, type = input.plot_visibility }
}


input_group {
    "Buy Outside Bar",
    colorBuy2 = input { default = "red", type = input.color }, 
    visibleBuy2 = input { default = true, type = input.plot_visibility }
}

input_group {
    "Sell Outside Bar",
    colorSell2 = input { default = "red", type = input.color },
    visibleSell2 = input { default = true, type = input.plot_visibility }
}

local avgFast = averages[MaFast_average]
local titleFast = inputs[MaFast_title]

local avgSlow = averages[MaSlow_average]
local titleSlow = inputs[MaSlow_title]

local avgTrend = averages[MaTrend_average]
local titleTrend = inputs[MaTrend_title]

if visibleFast == true then
    plot(avgFast(titleFast,MaFast_period),"Ma Fast",colorFast,widthFast)
end

if visibleSlow == true then
    plot(avgSlow(titleSlow,MaSlow_period),"Ma Slow",colorSlow,widthSlow)
end

if visibleTrend == true then
    plot(avgTrend(titleTrend,MaTrend_period),"Ma Trend",colorTrend,widthTrend)
end

candle_time = {"1s", "5s", "10s", "15s", "30s", "1m", "2m", "5m", "10m", "15m", "30m", "1H", "2H", "4H", "8H", "12H", "1D", "1W", "1M", "1Y"}
candle_time_res = input(6,"Candle check resolution",input.string_selection,candle_time)

sec = security (current_ticker_id, candle_time[candle_time_res])

filter_source = {"1s", "5s", "10s", "15s", "30s", "1m", "2m", "5m", "10m", "15m", "30m", "1H", "2H", "4H", "8H", "12H", "1D", "1W", "1M", "1Y"}
filter_pa_index = input(8,"Candle check resolution",input.string_selection,filter_source)

filter_pa = security (current_ticker_id, filter_source[filter_pa_index])

-- SMA5

instrument {
    name = 'SMA5',
    short_name = 'SMA5',
    icon = 'https://i.pinimg.com/474x/c8/7b/cf/c87bcf1c27a47222f6174f67b729bb83.jpg',
    overlay = true
}

EMA_PERIOD = input(5,"EMA Period",input.integer,1,1000,1)
CANDLE_VALUE = input(1,"Candle Value", input.string_selection,inputs.titles)

SMA_AUX_PERIOD = input(6,"SMA Aux Period",input.integer,1,1000,1)

input_group {
    "Compra",
    colorBuy = input { default = "green", type = input.color }, 
    visibleBuy = input { default = true, type = input.plot_visibility }
}

input_group {
    "Venda",
    colorSell = input { default = "red", type = input.color },
    visibleSell = input { default = true, type = input.plot_visibility }
}

local candleValue = inputs[CANDLE_VALUE]

-- Moving Average EMA
emaValue = ema(candleValue, EMA_PERIOD)
input_group {
    "front.middle line",
    middle_line_visible = input { default = false, type = input.plot_visibility },
    middle_line_color   = input { default = "", type = input.color },
    middle_line_width   = input { default = 1, type = input.line_width }
}

-- Moving Average SMA aux
smaValueAux = sma(candleValue, SMA_AUX_PERIOD)

plot (emaValue, "Middle", middle_line_color, middle_line_width)
plot(smaValueAux, "Middle", middle_line_color, middle_line_width)


BUY_CONDITION = conditional((emaValue > smaValueAux and emaValue > smaValueAux[1]) and  (emaValue[1] < smaValueAux and emaValue[1] < smaValueAux[1]))
SELL_CONDITION = conditional((emaValue < smaValueAux and emaValue < smaValueAux[1]) and (emaValue[1] > smaValueAux and emaValue[1] > smaValueAux[1])) 
        
    instrument {
    name = 'SMA3X5',
    short_name = 'SMA-ENG',
    icon = 'indicators:BB',
    overlay = true
}

-- SMA5
-- Create BY MON

MaFast_period = input(5,"Ma Fast period",input.integer,1,1000,1)
MaFast_average = input(1,"Ma Fast average", input.string_selection,averages.titles)
MaFast_title = input(1,"Ma Fast title", input.string_selection,inputs.titles)

MaSlow_period = input(1,"Ma Slow period",input.integer,1,1000,1)
MaSlow_average = input(2,"Ma Slow average", input.string_selection,averages.titles)
MaSlow_title = input(1,"Ma Slow title", input.string_selection,inputs.titles)

MaTrend_period = input(100,"Ma Trend period",input.integer,1,1000,5)
MaTrend_average = input(2,"Ma Trend average", input.string_selection,averages.titles)
MaTrend_title = input(1,"Ma Trend title", input.string_selection,inputs.titles)

-- Create BY MON

input_group {
    "Ma Fast Line",
    colorFast = input { default = "Red", type = input.color },
    widthFast = input { default = 2, type = input.line_width},
    visibleFast = input { default = true, type = input.plot_visibility }
}


input_group {
    "Buy Outside Bar",
    colorBuy2 = input { default = "red", type = input.color }, 
    visibleBuy2 = input { default = true, type = input.plot_visibility }
}

input_group {
    "Sell Outside Bar",
    colorSell2 = input { default = "red", type = input.color },
    visibleSell2 = input { default = true, type = input.plot_visibility }
}

local avgFast = averages[MaFast_average]
local titleFast = inputs[MaFast_title]

local avgSlow = averages[MaSlow_average]
local titleSlow = inputs[MaSlow_title]

local avgTrend = averages[MaTrend_average]
local titleTrend = inputs[MaTrend_title]

if visibleFast == true then
    plot(avgFast(titleFast,MaFast_period),"Ma Fast",colorFast,widthFast)
end

if visibleSlow == true then
    plot(avgSlow(titleSlow,MaSlow_period),"Ma Slow",colorSlow,widthSlow)
end

if visibleTrend == true then
    plot(avgTrend(titleTrend,MaTrend_period),"Ma Trend",colorTrend,widthTrend)
end

candle_time = {"1s", "5s", "10s", "15s", "30s", "1m", "2m", "5m", "10m", "15m", "30m", "1H", "2H", "4H", "8H", "12H", "1D", "1W", "1M", "1Y"}
candle_time_res = input(6,"Candle check resolution",input.string_selection,candle_time)

sec = security (current_ticker_id, candle_time[candle_time_res])

filter_source = {"1s", "5s", "10s", "15s", "30s", "1m", "2m", "5m", "10m", "15m", "30m", "1H", "2H", "4H", "8H", "12H", "1D", "1W", "1M", "1Y"}
filter_pa_index = input(8,"Candle check resolution",input.string_selection,filter_source)

filter_pa = security (current_ticker_id, filter_source[filter_pa_index])

instrument { name = "ZigZag", overlay = true }
percentage = input (1, "Percentage", input.double, 0.01, 100, 1.0) / 100
period = 3
input_group {
    "front.ind.dpo.generalline",
    up_color = input { default = "#FF7700", type = input.color },
    down_color = input { default = "#57A1D0", type = input.color },
    width = input { default = 1, type = input.line_width }
}
local reference = make_series ()
reference:set(nz(reference[1], high))
local is_direction_up = make_series ()
is_direction_up:set(nz(is_direction_up[1], true))
local htrack = make_series ()
local ltrack = make_series ()
local pivot = make_series ()
reverse_range = reference * percentage / 100
if get_value (is_direction_up) then
    htrack:set (max(high, nz(htrack[1], high)))
    if close < htrack[1] - reverse_range then
        pivot:set (htrack)
        is_direction_up:set (false)
        reference:set(htrack)
    end
else
    ltrack:set (min(low, nz(ltrack[1], low)))
    if close > ltrack[1] + reverse_range then
        pivot:set (ltrack)
        is_direction_up:set(true)
        reference:set (ltrack)
    end
end
color = is_direction_up() and  up_color or down_color
plot(pivot, 'ZZ', color, width, -1, style.solid_line, na_mode.continue)


instrument {
    name = 'MON SCRIPT',
    short_name = 'MON QUIET',
    icon = 'https://blog.iqoption.com/wp-content/uploads/2022/05/what-is-iq-option.jpg',
    overlay =true
}

-- Create BY MON
-- Name "MON Quiet"

local N = modf(5/2)

local smaLine = sma(close, 5)

BearishFractal = high[N]  > high[N-2] and 
                 high[N]  > high[N-1] and 
                 high[N]  > high[N+1] and 
                 high[N]  > high[N+2]  
                
            
BullishFractal = low[N] < low[N-2] and 
                 low[N] < low[N-1] and
                 low[N] < low[N+1] and
                 low[N] < low[N+2] 
 --Plot Fractal   
plot_shape(BearishFractal, "BearishFractal", shape_style.triangledown, shape_size.large, "white", shape_location.abovebar, -N, "mon sell", "white") 
plot_shape(BullishFractal, "BullishFractal", shape_style.triangleup, shape_size.large, "white", shape_location.belowbar, -N, "mon buy", "yellow")


buy  = BullishFractal and close > smaLine 
sell = BearishFractal and close < smaLine
  
-- Create BY MON
-- Thank you
