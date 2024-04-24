-- MON SCRIPT - Support and Resistance

instrument {
    name = 'MON SCRIPT - Support and resistance barry',
    icon = 'indicators:RSI',
    overlay = true
}

boxp = input(21, "Darvas box length", input.integer, 5)

input_group {
    "Support and resistance",
    top_color = input { default = "red", type = input.color },
    bottom_color = input { default = "green", type = input.color },
}

RST = boxp

RSTT = value.when(high >= highest(high, RST), high, 0)
RSTB = value.when(low <= lowest(low, RST), low, 0)
plot(RSTT, "Resistance", iff(RSTT ~= RSTT[1], na, top_color), 4, 0, style.levels, na_mode.restart)
plot(RSTB, "Support", iff(RSTB ~= RSTB[1], na, bottom_color), 4, 0, style.levels, na_mode.restart)


-- MON SCRIPT - SMA3X5

instrument {
    name = 'MON SCRIPT - SMA3X5',
    short_name = 'SMA-ENG',
    icon = 'indicators:BB',
    overlay = true
}

MaFast_period = input(3, "Fast MA period", input.integer, 1, 1000, 1)
MaFast_average = input(1, "Fast MA average", input.string_selection, averages.titles)
MaFast_title = input(1, "Fast MA title", input.string_selection, inputs.titles)

MaSlow_period = input(5, "Slow MA period", input.integer, 1, 1000, 1)
MaSlow_average = input(2, "Slow MA average", input.string_selection, averages.titles)
MaSlow_title = input(1, "Slow MA title", input.string_selection, inputs.titles)

MaTrend_period = input(100, "Trend MA period", input.integer, 1, 1000, 5)
MaTrend_average = input(2, "Trend MA average", input.string_selection, averages.titles)
MaTrend_title = input(1, "Trend MA title", input.string_selection, inputs.titles)

-- Create MON SCRIPT

input_group {
    "Fast MA Line",
    colorFast = input { default = "Yellow", type = input.color },
    widthFast = input { default = 2, type = input.line_width},
    visibleFast = input { default = true, type = input.plot_visibility }
}

input_group {
    "Slow MA Line",
    colorSlow = input { default = "Red", type = input.color },
    widthSlow = input { default = 2, type = input.line_width},
    visibleSlow = input { default = true, type = input.plot_visibility }
}

input_group {
    "Trend MA Line",
    colorTrend = input { default = "Green", type = input.color },
    widthTrend = input { default = 2, type = input.line_width},
    visibleTrend = input { default = true, type = input.plot_visibility }
}

local avgFast = averages[MaFast_average]
local titleFast = inputs[MaFast_title]

local avgSlow = averages[MaSlow_average]
local titleSlow = inputs[MaSlow_title]

local avgTrend = averages[MaTrend_average]
local titleTrend = inputs[MaTrend_title]

if visibleFast then
    plot(avgFast(titleFast, MaFast_period), "Fast MA", colorFast, widthFast)
end

if visibleSlow then
    plot(avgSlow(titleSlow, MaSlow_period), "Slow MA", colorSlow, widthSlow)
end

if visibleTrend then
    plot(avgTrend(titleTrend, MaTrend_period), "Trend MA", colorTrend, widthTrend)
end

candle_time = {"1s", "5s", "10s", "15s", "30s", "1m", "2m", "5m", "10m", "15m", "30m", "1H", "2H", "4H", "8H", "12H", "1D", "1W", "1M", "1Y"}
candle_time_res = input(6, "Candle check resolution", input.string_selection, candle_time)

sec = security (current_ticker_id, candle_time[candle_time_res])

filter_source = {"1s", "5s", "10s", "15s", "30s", "1m", "2m", "5m", "10m", "15m", "30m", "1H", "2H", "4H", "8H", "12H", "1D", "1W", "1M", "1Y"}
filter_pa_index = input(8, "Candle check resolution", input.string_selection, filter_source)

filter_pa = security (current_ticker_id, filter_source[filter_pa_index])

-- MON SCRIPT - SMA5

instrument {
    name = 'MON SCRIPT - SMA5',
    short_name = 'SMA5',
    icon = 'https://i.pinimg.com/474x/c8/7b/cf/c87bcf1c27a47222f6174f67b729bb83.jpg',
    overlay = true
}

EMA_PERIOD = input(5, "EMA Period", input.integer, 1, 1000, 1)
CANDLE_VALUE = input(1, "Candle Value", input.string_selection, inputs.titles)

SMA_AUX_PERIOD = input(6, "SMA Aux Period", input.integer, 1, 1000, 1)

input_group {
    "Buy",
    colorBuy = input { default = "Green", type = input.color }, 
    visibleBuy = input { default = true, type = input.plot_visibility }
}

input_group {
    "Sell",
    colorSell = input { default = "Red", type = input.color },
    visibleSell = input { default = true, type = input.plot_visibility }
}

local candleValue = inputs[CANDLE_VALUE]

-- Moving Average EMA
emaValue = ema(candleValue, EMA_PERIOD)

input_group {
    "Middle line",
    middle_line_visible = input { default = false, type = input.plot_visibility },
    middle_line_color   = input { default = "", type = input.color },
    middle_line_width   = input { default = 1, type = input.line_width }
}

-- Moving Average SMA aux
smaValueAux = sma(candleValue, SMA_AUX_PERIOD)

plot(emaValue, "Middle", middle_line_color, middle_line_width)
plot(smaValueAux, "Middle", middle_line_color, middle_line_width)

BUY_CONDITION = emaValue > smaValueAux and emaValue > smaValueAux[1] and emaValue[1] < smaValueAux and emaValue[1] < smaValueAux[1]
SELL_CONDITION = emaValue < smaValueAux and emaValue < smaValueAux[1] and emaValue[1] > smaValueAux and emaValue[1] > smaValueAux[1]

-- ZigZag

instrument {
    name = 'MON SCRIPT - ZigZag',
    overlay = true
}

percentage = input(1, "Percentage", input.double, 0.01, 100, 1.0) / 100
period = 3

input_group {
    "ZigZag Line",
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
if is_direction_up() then
    htrack:set(max(high, nz(htrack[1], high)))
    if close < htrack[1] - reverse_range then
        pivot:set(htrack)
        is_direction_up:set(false)
        reference:set(htrack)
    end
else
    ltrack:set(min(low, nz(ltrack[1], low)))
    if close > ltrack[1] + reverse_range then
        pivot:set(ltrack)
        is_direction_up:set(true)
        reference:set(ltrack)
    end
end
color = is_direction_up() and up_color or down_color
plot(pivot, 'ZigZag', color, width, -1, style.solid_line, na_mode.continue)

-- MON SCRIPT - Fractal

instrument {
    name = 'MON SCRIPT',
    short_name = 'MON SCRIPT',
    icon = 'https://blog.iqoption.com/wp-content/uploads/2022/05/what-is-iq-option.jpg',
    overlay = true
}

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

plot_shape(BearishFractal, "BearishFractal", shape_style.triangledown, shape_size.large, "white", shape_location.abovebar, -N, "Indy sell", "white") 
plot_shape(BullishFractal, "BullishFractal", shape_style.triangleup, shape_size.large, "white", shape_location.belowbar, -N, "Indy buy", "yellow")

buy = BullishFractal and close > smaLine 
sell = BearishFractal and close < smaLine
