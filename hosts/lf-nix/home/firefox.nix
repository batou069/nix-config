{
  lib,
  config,
  pkgs,
  ...
}:
{
programs.firefox = {
      enable = true;
      profiles.lf = {
        bookmarks = [
          {
          name = "wikipedia";
          tags = [ "wiki" ];
          keyword = "wiki";
          url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
          }
        ]
      }



```
{
   name = "Get Help";
          tags = [ "firefox" ];
          keyword = "gethelp";
          url = "https://support.mozilla.org/products/firefox";

}
{
   name = "Customize Firefox";
          tags = [ "firefox" ];
          keyword = "customizefirefox";
          url = "https://support.mozilla.org/kb/customize-firefox-controls-buttons-and-toolbars?utm_source=firefox-browser&utm_medium=default-bookmarks&utm_campaign=customize";

}
{
   name = "Get Involved";
          tags = [ "mozilla" ];
          keyword = "getinvolved";
          url = "https://www.mozilla.org/contribute/";

}
{
   name = "About Us";
          tags = [ "mozilla" ];
          keyword = "aboutus";
          url = "https://www.mozilla.org/about/";

}
{
   name = "Get Help";
          tags = [ "firefox" ];
          keyword = "gethelp";
          url = "https://support.mozilla.org/products/firefox";

}
{
   name = "Customize Firefox";
          tags = [ "firefox" ];
          keyword = "customizefirefox";
          url = "https://support.mozilla.org/kb/customize-firefox-controls-buttons-and-toolbars?utm_source=firefox-browser&utm_medium=default-bookmarks&utm_campaign=customize";

}
{
   name = "Get Involved";
          tags = [ "mozilla" ];
          keyword = "getinvolved";
          url = "https://www.mozilla.org/contribute/";

}
{
   name = "About Us";
          tags = [ "mozilla" ];
          keyword = "aboutus";
          url = "https://www.mozilla.org/about/";

}
{
   name = "Recently Bookmarked";
          tags = [ "firefox" ];
          keyword = "recentlybookmarked";
          url = "place:parent=menu________&parent=unfiled_____&parent=toolbar_____&queryType=1&sort=12&maxResults=10&excludeQueries=1";

}
{
   name = "Recent Tags";
          tags = [ "firefox" ];
          keyword = "recenttags";
          url = "place:type=6&sort=14&maxResults=10";

}
{
   name = "seminar for women experience body at DuckDuckGo";
          tags = [ "women", "seminar", "duckduckgo" ];
          keyword = "seminarwomen";
          url = "https://duckduckgo.com/?q=seminar+for+women+experience+body&t=lm&atb=v158-1&ia=web";

}
{
   name = "Nutrition Seminars and Workshops";
          tags = [ "nutrition", "seminar", "workshop" ];
          keyword = "nutritionseminars";
          url = "https://lesliebeck.com/nutrition-services/nutrition-seminars-and-workshops";

}
{
   name = "10 Writing Ideas Concerning Women";
          tags = [ "writing", "women", "ideas" ];
          keyword = "writingwomen";
          url = "https://www.thoughtco.com/writing-ideas-concerning-women-31733";

}
{
   name = "Body, Mind, and Spirit | The Pioneer Woman";
          tags = [ "wellness", "women" ];
          keyword = "bodymindspirit";
          url = "https://thepioneerwoman.com/confessions/body-mind-and-spirit/";

}
{
   name = "5 Rules For The Spiritually Empowered Woman";
          tags = [ "spirituality", "women", "empowerment" ];
          keyword = "empoweredwoman";
          url = "https://www.mindbodygreen.com/0-7694/5-rules-for-the-spiritually-empowered-woman.html";

}
{
   name = "Balancing Body, Mind and Spirit | Women's Radio Network";
          tags = [ "wellness", "women", "radio" ];
          keyword = "balancingbodymindspirit";
          url = "http://www.womensradio.com/2019/05/balancing-body-mind-and-spirit/";

}
{
   name = "What happens to a woman’s body when she's raising kids, working, and trying to have it all - Business Insider";
          tags = [ "women", "health", "worklife" ];
          keyword = "womansbody";
          url = "https://www.businessinsider.com/nisha-jackson-womans-body-when-shes-raising-kids-working-have-it-all-2019-4";

}
{
   name = "Weight Training for Women: The Ultimate Strength Training Plan";
          tags = [ "fitness", "women", "training" ];
          keyword = "weighttrainingwomen";
          url = "https://www.womenshealthmag.com/health/a19921596/weight-lifting-training-program/";

}
{
   name = "Women's Empowerment Seminar";
          tags = [ "women", "empowerment", "seminar" ];
          keyword = "womensempowerment";
          url = "https://www.kravmaga.com/saam_2019/";

}
{
   name = "Seminars • MennoHenselmans.com";
          tags = [ "seminar", "fitness" ];
          keyword = "mennohenselmans";
          url = "https://mennohenselmans.com/seminar/";

}
{
   name = "Composerize";
          tags = [ "tool", "development" ];
          keyword = "composerize";
          url = "https://www.composerize.com/";

}
{
   name = "OpenAI tokenizer";
          tags = [ "ai", "openai", "tokenizer" ];
          keyword = "openaistokenizer";
          url = "https://platform.openai.com/tokenizer";

}
{
   name = "Gemini";
          tags = [ "ai", "google" ];
          keyword = "gemini";
          url = "https://gemini.google.com/app/250fbd46aa83c4cc";

}
{
   name = "Perplexity";
          tags = [ "ai", "search" ];
          keyword = "perplexity";
          url = "https://www.perplexity.ai/";

}
{
   name = "Chat Playground - OpenAI API";
          tags = [ "ai", "openai", "chat" ];
          keyword = "chatplayground";
          url = "https://platform.openai.com/playground/chat?models=gpt-4o";

}
{
   name = "(12) Hirak Berlin حراك برلين🇩🇿🇩🇪 (@BerlinHirak) / X";
          tags = [ "socialmedia", "politics" ];
          keyword = "hirakberlin";
          url = "https://x.com/BerlinHirak";

}
{
   name = "(16) Oren Barsky 🎗️ on X: \"For most Arabs who experienced the Nakba, it was also the first time they discovered they were Palestinians. Until then, they were primarily Arabs, migrant workers who had arrived only a decade or two earlier to make a living, and suddenly found themselves as Palestinian\" / X";
          tags = [ "history", "palestine", "socialmedia" ];
          keyword = "orenbarsky";
          url = "https://x.com/orenbarsky/status/1791579971812479209";

}
{
   name = "Facebook";
          tags = [ "socialmedia" ];
          keyword = "facebook";
          url = "https://www.facebook.com/ilja.sichrovsky";

}
{
   name = "YoutubeBuddy · Streamlit";
          tags = [ "youtube", "tool", "ai" ];
          keyword = "youtubebuddy";
          url = "https://youtubebuddy.streamlit.app/";

}
{
   name = "Complete List of Prompts & Styles for Suno AI Music (2024) | by Travis Nicholson | Medium";
          tags = [ "ai", "music", "prompts" ];
          keyword = "sunoaimusic";
          url = "https://travisnicholson.medium.com/complete-list-of-prompts-styles-for-suno-ai-music-2024-33ecee85f180";

}
{
   name = "Untitled prompt | Google AI Studio";
          tags = [ "ai", "google" ];
          keyword = "googleaistudio";
          url = "https://aistudio.google.com/prompts/new_chat";

}
{
   name = "IBI Trade (US)";
          tags = [ "finance", "trading" ];
          keyword = "ibitradeus";
          url = "https://ibi.viewtrade.com/";

}
{
   name = "IBI Spark (IL)";
          tags = [ "finance", "trading" ];
          keyword = "ibisparkil";
          url = "https://sparkibi.ordernet.co.il/#/auth";

}
{
   name = "Tradovate - Platform Knowledge Videos";
          tags = [ "finance", "trading", "education" ];
          keyword = "tradovatevideos";
          url = "https://www.tradovate.com/videos/?utm_term=demo&utm_campaign=Demo%20to%20Customer%202019&utm_medium=Email&_hsmi=103430268&utm_content=Demo%20to%20Customer%20%233%20%E2%80%94%20Features&utm_source=email";

}
{
   name = "NextGen IBI";
          tags = [ "finance", "trading" ];
          keyword = "nextgenibi";
          url = "https://ibi.orbisfn.io/login";

}
{
   name = "Tiger Brokers _ Hong Kong / U.S. Stock Market Quotes";
          tags = [ "finance", "trading", "stocks" ];
          keyword = "tigerbrokers";
          url = "https://www.itiger.com/sg";

}
{
   name = "Interactive Brokers";
          tags = [ "finance", "trading" ];
          keyword = "interactivebrokers";
          url = "https://www.interactivebrokers.com/";

}
{
   name = "Swing Alerts | ClickCapital";
          tags = [ "finance", "trading", "alerts" ];
          keyword = "swingalerts";
          url = "https://www.clickcapital.io/alerts-open-trades";

}
{
   name = "Stock Picks | ClickCapital";
          tags = [ "finance", "trading", "stocks" ];
          keyword = "stockpicks";
          url = "https://www.clickcapital.io/stock-picks-members";

}
{
   name = "Yahoo Finance - Stock Market Live, Quotes, Business & Finance News";
          tags = [ "finance", "news", "stocks" ];
          keyword = "yahoofinance";
          url = "https://finance.yahoo.com/";

}
{
   name = "ETF Screener | etf.com";
          tags = [ "finance", "etf", "screener" ];
          keyword = "etfscreener";
          url = "https://www.etf.com/etfanalytics/etf-screener";

}
{
   name = "ETF Tools - stockanalysis.com";
          tags = [ "finance", "etf", "tools" ];
          keyword = "etftools";
          url = "https://stockanalysis.com/etf/screener/";

}
{
   name = "ETF Research Center";
          tags = [ "finance", "etf", "research" ];
          keyword = "etfresearch";
          url = "https://www.etfrc.com/index.php";

}
{
   name = "ETF Database: The Original & Comprehensive Guide to ETFs";
          tags = [ "finance", "etf", "database" ];
          keyword = "etfdatabase";
          url = "https://etfdb.com/";

}
{
   name = "SweepCast | Unusual Options Activity for Retail Traders - Follow Smart Money";
          tags = [ "finance", "options", "trading" ];
          keyword = "sweepcast";
          url = "https://www.sweepcast.com/";

}
{
   name = "Pine Script™ v5 User Manual";
          tags = [ "pinescript", "tradingview", "documentation" ];
          keyword = "pinescriptmanual";
          url = "https://www.tradingview.com/pine-script-docs/en/v5/Introduction.html";

}
{
   name = "Free Options Trading Courses | Option Alpha";
          tags = [ "options", "trading", "education" ];
          keyword = "optionalpha";
          url = "https://optionalpha.com/courses";

}
{
   name = "Learn to Trade & Invest: Insights, Resources";
          tags = [ "trading", "investing", "education" ];
          keyword = "tastytradelearn";
          url = "https://tastytrade.com/learn/";

}
{
   name = "Introduction to Options - CME Group";
          tags = [ "options", "cme", "education" ];
          keyword = "cmeoptionsintro";
          url = "https://www.cmegroup.com/education/courses/introduction-to-options.html";

}
{
   name = "Option Strategies - CME Group";
          tags = [ "options", "cme", "strategies" ];
          keyword = "cmeoptionstrategies";
          url = "https://www.cmegroup.com/education/courses/option-strategies.html";

}
{
   name = "Tools for Option Analysis - CME Group";
          tags = [ "options", "cme", "analysis" ];
          keyword = "cmeoptiontools";
          url = "https://www.cmegroup.com/education/courses/tools-for-option-analysis.html";

}
{
   name = "Bloomberg for Education";
          tags = [ "finance", "education", "bloomberg" ];
          keyword = "bloombergeducation";
          url = "https://portal.bloombergforeducation.com/";

}
{
   name = "The Basics of Treasuries Basis - CME Group";
          tags = [ "finance", "fixedincome", "cme" ];
          keyword = "cmetreasuries";
          url = "https://www.cmegroup.com/education/courses/introduction-to-treasuries/the-basics-of-treasuries-basis.html";

}
{
   name = "Technical Analysis - CME Group";
          tags = [ "finance", "analysis", "cme" ];
          keyword = "cmetechanalysis";
          url = "https://www.cmegroup.com/education/courses/technical-analysis.html";

}
{
   name = "Trading and Analysis - CME Group";
          tags = [ "finance", "trading", "analysis", "cme" ];
          keyword = "cmetradinganalysis";
          url = "https://www.cmegroup.com/education/courses/trading-and-analysis.html";

}
{
   name = "Learn about Key Economic Events - CME Group";
          tags = [ "finance", "economics", "cme" ];
          keyword = "cmeeconomicevents";
          url = "https://www.cmegroup.com/education/courses/learn-about-key-economic-events.html";

}
{
   name = "Trade and Risk Management - CME Group";
          tags = [ "finance", "riskmanagement", "cme" ];
          keyword = "cmeriskmanagement";
          url = "https://www.cmegroup.com/education/courses/trade-and-risk-management.html";

}
{
   name = "Introduction to Equity Index Products - CME Group";
          tags = [ "finance", "equity", "cme" ];
          keyword = "cmeequityintro";
          url = "https://www.cmegroup.com/education/courses/introduction-to-equity-index-products.html";

}
{
   name = "Futures vs. ETFs - CME Group";
          tags = [ "finance", "futures", "etf", "cme" ];
          keyword = "cmefuturesvsetf";
          url = "https://www.cmegroup.com/education/courses/futures-vs-etfs.html";

}
{
   name = "Reddit - Dive into anything";
          tags = [ "reddit", "trading" ];
          keyword = "realddaytradingwiki";
          url = "https://www.reddit.com/r/RealDayTrading/wiki/index/";

}
{
   name = "(5) Adding a Sector List and the Top 10 for each sector to a Trading View watchlist : RealDayTrading";
          tags = [ "trading", "watchlist", "sectors" ];
          keyword = "tradingviewsectors";
          url = "https://www.reddit.com/r/RealDayTrading/comments/18ap05y/adding_a_sector_list_and_the_top_10_for_each/";

}
{
   name = "Sign in to TC2000®";
          tags = [ "trading", "platform" ];
          keyword = "tc2000signin";
          url = "https://www.tc2000.com/sign-in?webplatform=true&returnURL=https://webplatform.tc2000.com/RASHTML5Gateway/";

}
{
   name = "(5) Sector scanner for Trading View : RealDayTrading";
          tags = [ "trading", "scanner", "sectors" ];
          keyword = "tradingviewsectorscanner";
          url = "https://www.reddit.com/r/RealDayTrading/comments/x8v8cd/sector_scanner_for_trading_view/";

}
{
   name = "> Sector Relative Strength — Indicator by atlas54000 — TradingView";
          tags = [ "tradingview", "indicator", "relativestrength" ];
          keyword = "sectorrelativestrength";
          url = "https://www.tradingview.com/script/fcSCAIv5-Sector-Relative-Strength/";

}
{
   name = "(5) I \"Shorted Stupid\" and I Got Burned! : RealDayTrading";
          tags = [ "trading", "lessons" ];
          keyword = "shortedstupid";
          url = "https://www.reddit.com/r/RealDayTrading/comments/y24905/i_shorted_stupid_and_i_got_burned/";

}
{
   name = "> (5) Bearish Trend Days. How To Spot Them and How To Trade Them : RealDayTrading";
          tags = [ "trading", "bearish", "strategy" ];
          keyword = "bearishtrenddays";
          url = "https://www.reddit.com/r/RealDayTrading/comments/xy8756/bearish_trend_days_how_to_spot_them_and_how_to/";

}
{
   name = ">> (10) Bearish Trend Days - How To Trade Them - YouTube";
          tags = [ "trading", "youtube", "bearish" ];
          keyword = "bearishtrenddaysyoutube";
          url = "https://www.youtube.com/watch?v=kPfWxS12yUY";

}
{
   name = "> (10) Why This Gap and Go Pattern Failed - YouTube";
          tags = [ "trading", "youtube", "patterns" ];
          keyword = "gapandgofailed";
          url = "https://www.youtube.com/watch?v=FmhUYeGCGgU";

}
{
   name = "(4) Simple RS Strategy using trendline (Great for newbies) : RealDayTrading";
          tags = [ "trading", "strategy", "beginners" ];
          keyword = "simplersstrategy";
          url = "https://www.reddit.com/r/RealDayTrading/comments/ty0tjw/simple_rs_strategy_using_trendline_great_for/";

}
{
   name = "(5) A Tool For Compiling Your Market Rebound Picks : RealDayTrading";
          tags = [ "trading", "tools", "marketrebound" ];
          keyword = "marketreboundpicks";
          url = "https://www.reddit.com/r/RealDayTrading/comments/v5kjav/a_tool_for_compiling_your_market_rebound_picks/";

}
{
   name = "(5) Analyzed 450 Trades - This might be helpful : RealDayTrading";
          tags = [ "trading", "analysis" ];
          keyword = "analyzedtrades";
          url = "https://www.reddit.com/r/RealDayTrading/comments/t7li41/analyzed_450_trades_this_might_be_helpful/";

}
{
   name = "(5) Need help with identifying institutional support. : RealDayTrading";
          tags = [ "trading", "support", "institutional" ];
          keyword = "institutionalsupport";
          url = "https://www.reddit.com/r/RealDayTrading/comments/16zzjun/need_help_with_identifying_institutional_support/";

}
{
   name = "(5) Update to relative strength stock and sector script post : RealDayTrading";
          tags = [ "trading", "relativestrength", "script" ];
          keyword = "relativestrengthupdate";
          url = "https://www.reddit.com/r/RealDayTrading/comments/weuik4/update_to_relative_strength_stock_and_sector_script_post/";

}
{
   name = "(5) Real Relative Strength to SECTOR Indicator + Auto Sector Selection [TOS/TV] : RealDayTrading";
          tags = [ "trading", "relativestrength", "indicator" ];
          keyword = "realsectorrs";
          url = "https://www.reddit.com/r/RealDayTrading/comments/x9dwv0/real_relative_strength_to_sector_indicator_auto/";

}
{
   name = "(5) Strong sector or strong stock? : RealDayTrading";
          tags = [ "trading", "sectors", "stocks" ];
          keyword = "strongsectorstock";
          url = "https://www.reddit.com/r/RealDayTrading/comments/10n9i59/strong_sector_or_strong_stock/";

}
{
   name = "(5) Sector / Industry Strength Comparison on Tradingview : RealDayTrading";
          tags = [ "tradingview", "sectors", "industry" ];
          keyword = "sectorindustrystrength";
          url = "https://www.reddit.com/r/RealDayTrading/comments/tiprot/sector_industry_strength_comparison_on_tradingview/";

}
{
   name = "(5) (Expanded to *Most* Stocks) Real Relative Strength to SECTOR Indicator + Auto Sector Selection [TOS] : RealDayTrading";
          tags = [ "trading", "relativestrength", "indicator" ];
          keyword = "expandedrealsectorrs";
          url = "https://www.reddit.com/r/RealDayTrading/comments/z02d6b/expanded_to_most_stocks_real_relative_strength_to/";

}
{
   name = "(5) Stacked Stock/Sector/Market RS/RW Arrows for TradingView : RealDayTrading";
          tags = [ "tradingview", "indicators", "rsrw" ];
          keyword = "stackedrsrw";
          url = "https://www.reddit.com/r/RealDayTrading/comments/z9u03i/stacked_stocksectormarket_rsrw_arrows_for/";

}
{
   name = "(5) Question About Sector Performance : RealDayTrading";
          tags = [ "trading", "sectors", "performance" ];
          keyword = "sectorperformancequestion";
          url = "https://www.reddit.com/r/RealDayTrading/comments/170uagf/question_about_sector_performance/";

}
{
   name = "(5) Relative Strength to stock and sector indicator for TOS : RealDayTrading";
          tags = [ "trading", "relativestrength", "indicator" ];
          keyword = "tosrelativestrength";
          url = "https://www.reddit.com/r/RealDayTrading/comments/wb3x7c/relative_strength_to_stock_and_sector_indicator/";

}
{
   name = "(5) Sector / Industry Strength Comparison on Tradingview : RealDayTrading";
          tags = [ "tradingview", "sectors", "industry" ];
          keyword = "sectorindustrystrength";
          url = "https://www.reddit.com/r/RealDayTrading/comments/tiprot/sector_industry_strength_comparison_on_tradingview/";

}
{
   name = "(5) I \"Shorted Stupid\" and I Got Burned! : RealDayTrading";
          tags = [ "trading", "lessons" ];
          keyword = "shortedstupid";
          url = "https://www.reddit.com/r/RealDayTrading/comments/y24905/i_shorted_stupid_and_i_got_burned/";

}
{
   name = "(5) A very handy way to pull financial data : RealDayTrading";
          tags = [ "finance", "data", "tools" ];
          keyword = "financialdatapull";
          url = "https://www.reddit.com/r/RealDayTrading/comments/11widn4/a_very_handy_way_to_pull_financial_data/";

}
{
   name = "> Download | OpenBB Terminal";
          tags = [ "finance", "tools", "openbb" ];
          keyword = "openbbdownload";
          url = "https://my.openbb.co/app/terminal/download";

}
{
   name = "Real Relative Strength to SECTOR Indicator + Auto Sector Selection [TOS/TV] : RealDayTrading";
          tags = [ "trading", "relativestrength", "indicator" ];
          keyword = "realsectorrs";
          url = "https://www.reddit.com/r/RealDayTrading/comments/x9dwv0/real_relative_strength_to_sector_indicator_auto/";

}
{
   name = "OpenBB Terminal Docs";
          tags = [ "finance", "tools", "documentation" ];
          keyword = "openbbdocs";
          url = "https://docs.openbb.co/terminal";

}
{
   name = "Order Types and Algos | Interactive Brokers LLC";
          tags = [ "trading", "interactivebrokers", "ordertypes" ];
          keyword = "ibkrordertypes";
          url = "https://www.interactivebrokers.com/en/trading/ordertypes.php";

}
{
   name = "Basic Economics | Trading Course | Traders' Academy | IBKR Campus";
          tags = [ "economics", "trading", "education" ];
          keyword = "ibkreconomics";
          url = "https://ibkrcampus.com/trading-course/introduction-to-microeconomics/?src=_X_MAILING_ID&eid=_X_EID&blst=NL-TI_cps_artclbtn";

}
{
   name = "Getting Started with TWS | Trading Lesson | Traders' Academy | IBKR Campus";
          tags = [ "trading", "tws", "education" ];
          keyword = "ibkrtwsgettingstarted";
          url = "https://ibkrcampus.com/trading-lessons/getting-started-with-tws/";

}
{
   name = "בית פרטי/ קוטג', פרדס חנה כרכור | אלפי מודעות חדשות בכל יום!";
          tags = [ "realestate", "israel" ];
          keyword = "yad2pardeshanna";
          url = "https://www.yad2.co.il/realestate/item/qi61ryus?ad-location=Main+feed+listings&opened-from=Feed+view&component-type=main_feed&index=19&color-type=Grey";

}
{
   name = "(1) Veena Krishnamurthy | LinkedIn";
          tags = [ "linkedin", "profile" ];
          keyword = "veenakrishnamurthy";
          url = "https://www.linkedin.com/in/veena-krishnamurthy/";

}
{
   name = "GitHub - wilsonfreitas/awesome-quant: A curated list of insanely awesome libraries, packages and resources for Quants (Quantitative Finance)";
          tags = [ "github", "finance", "quant" ];
          keyword = "awesomequant";
          url = "https://github.com/wilsonfreitas/awesome-quant";

}
{
   name = "OCC - Investor Education";
          tags = [ "finance", "education", "options" ];
          keyword = "occ";
          url = "https://www.theocc.com/company-information/investor-education";

}
{
   name = "koyfin";
          tags = [ "finance", "platform" ];
          keyword = "koyfin";
          url = "https://app.koyfin.com/home";

}
{
   name = "Select Sector SPDR ETFs - Sector Spiders ETFs | SPDR S&P Stock";
          tags = [ "finance", "etf", "sectors" ];
          keyword = "sectorspdrs";
          url = "https://www.sectorspdrs.com/";

}
{
   name = "Investopedia Stock Simulator";
          tags = [ "finance", "simulator", "investing" ];
          keyword = "investopediasimulator";
          url = "https://www.investopedia.com/simulator/portfolio";

}
{
   name = "מדריכים וכלים של פעמונים - paamonim";
          tags = [ "finance", "tools", "israel" ];
          keyword = "paamonimtools";
          url = "https://www.paamonim.org/he/%D7%9B%D7%9C%D7%99%D7%9D-%D7%95%D7%9E%D7%97%D7%A9%D7%91%D7%95%D7%A0%D7%99%D7%9D/";

}
{
   name = "TipRanks";
          tags = [ "finance", "research" ];
          keyword = "tipranks";
          url = "https://www.tipranks.com/dashboard";

}
{
   name = "(18) TWS Trading Tutorial | Order Types, Presets & Routing - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twstutorial";
          url = "https://www.youtube.com/watch?v=AMCNNNlK8D0&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=102&t=62s";

}
{
   name = "> (18) How to use Adjustable Stop and Scale Target Orders in TWS - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twsadjustableorders";
          url = "https://www.youtube.com/watch?v=RYykmLiGbMU&t=493s";

}
{
   name = "> (18) How to use a Bracket Order in TWS (Stop-loss/Take Profit) - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twsbracketorder";
          url = "https://www.youtube.com/watch?v=b-x_cwH99C4&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=63";

}
{
   name = "> (18) How to Properly Use Margin with Interactive Brokers - YouTube";
          tags = [ "trading", "interactivebrokers", "margin", "youtube" ];
          keyword = "ibkrmargin";
          url = "https://www.youtube.com/watch?v=Y-MmaJKQHAk&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=85";

}
{
   name = "> (18) Interactive Brokers TWS Platform: How to trade directly from the Charts! - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twscharttrading";
          url = "https://www.youtube.com/watch?v=SGSxig40mgY&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=101&t=390s";

}
{
   name = "> (18) How to FIX Your IBKR TWS Charts in 2 Minutes - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twsfixcharts";
          url = "https://www.youtube.com/watch?v=hrO3KoXs5MU&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=100";

}
{
   name = ">> (18) Step-by-Step TWS CHART Settings - (Interactive Brokers Tutorial) - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twschartsettings";
          url = "https://www.youtube.com/watch?v=F1d8r-MWjfM&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=111";

}
{
   name = "> (18) 10 Tips & Tricks To Master Interactive Brokers - YouTube";
          tags = [ "trading", "interactivebrokers", "youtube" ];
          keyword = "ibkrtips";
          url = "https://www.youtube.com/watch?v=HR0S-0sgb7o&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=108";

}
{
   name = ">> (18) Interactive Brokers Platform Tutorial for Day Trading 2023 (Level II, Hotkeys, Indicators etc) - YouTube";
          tags = [ "trading", "interactivebrokers", "youtube" ];
          keyword = "ibkrdaytradingtutorial";
          url = "https://www.youtube.com/watch?v=UWTWz2GZq30&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=106&t=866s";

}
{
   name = ">> (18) How to Set Up TWS layout/Interactive Brokers - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twssetup";
          url = "https://www.youtube.com/watch?v=mYVnhTe2ce0&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=74";

}
{
   name = ">> (18) Fastest Way to Trade on Interactive Brokers | Day Trading Buttons - YouTube";
          tags = [ "trading", "interactivebrokers", "youtube" ];
          keyword = "ibkrfasttrading";
          url = "https://www.youtube.com/watch?v=Mb0avUe0HxM&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=110";

}
{
   name = "Fear and Greed Index - Investor Sentiment | CNN";
          tags = [ "finance", "sentiment", "cnn" ];
          keyword = "feargreedindex";
          url = "https://edition.cnn.com/markets/fear-and-greed";

}
{
   name = "Set Up DNS For A Basic Website | Dyn Help Center";
          tags = [ "web", "dns", "hosting" ];
          keyword = "setupdns";
          url = "https://help.dyn.com/setting-up-dns-for-your-new-website/";

}
{
   name = "Visual Directory";
          tags = [ "software", "directory" ];
          keyword = "visualdirectory";
          url = "https://similarweb.officespacesoftware.com/visual-directory/floors/8/seats/973";

}
{
   name = "Google Analytics Solutions Gallery";
          tags = [ "googleanalytics", "analytics", "tools" ];
          keyword = "gasolutionsgallery";
          url = "https://analytics.google.com/analytics/gallery/?hl=en_US#posts/search/%3F_.type%3DDASHBOARD%26_.start%3D0/";

}
{
   name = "Verify view filters - Analytics Help";
          tags = [ "googleanalytics", "filters", "help" ];
          keyword = "gafilters";
          url = "https://support.google.com/analytics/answer/6046990?hl=en#zippy=%2Cin-this-article";

}
{
   name = "About regular expressions (regex) - Analytics Help";
          tags = [ "googleanalytics", "regex", "help" ];
          keyword = "garegex";
          url = "https://support.google.com/analytics/answer/1034324?hl=en";

}
{
   name = "Mini guides - Analytics Help";
          tags = [ "googleanalytics", "guides", "help" ];
          keyword = "gaminiguides";
          url = "https://support.google.com/analytics/topic/9328240";

}
{
   name = "Set up the Analytics global site tag - Analytics Help";
          tags = [ "googleanalytics", "tags", "help" ];
          keyword = "gaglobalsitetag";
          url = "https://support.google.com/analytics/answer/1008080#zippy=%2Cin-this-article";

}
{
   name = "Tag Assistant Legacy (by Google) - Chrome Web Store";
          tags = [ "googleanalytics", "chromeextension", "tools" ];
          keyword = "tagassistant";
          url = "https://chrome.google.com/webstore/detail/tag-assistant-legacy-by-g/kejbdjndbnbjgmefkgdddjlbokphdefk";

}
{
   name = "View the history of account changes (Universal Analytics properties) - Analytics Help";
          tags = [ "googleanalytics", "history", "help" ];
          keyword = "gaaccounthistory";
          url = "https://support.google.com/analytics/answer/2949085";

}
{
   name = "Diagnostics messages - Analytics Help";
          tags = [ "googleanalytics", "diagnostics", "help" ];
          keyword = "gadiagnostics";
          url = "https://support.google.com/analytics/answer/6006306#zippy=%2Cin-this-article";

}
{
   name = "Common issues - Analytics Help";
          tags = [ "googleanalytics", "issues", "help" ];
          keyword = "gacommonissues";
          url = "https://support.google.com/analytics/topic/1009691";

}
{
   name = "Google Analytics user permissions - Analytics Help";
          tags = [ "googleanalytics", "permissions", "help" ];
          keyword = "gaperissions";
          url = "https://support.google.com/analytics/answer/2884495";

}
{
   name = "Customer journey mapping: the path to loyal customers - Think with Google";
          tags = [ "marketing", "customerjourney", "google" ];
          keyword = "customerjourneymapping";
          url = "https://www.thinkwithgoogle.com/consumer-insights/consumer-journey/customer-journey-mapping/";

}
{
   name = "Adopting actionable data-driven marketing strategies - Think with Google";
          tags = [ "marketing", "datadriven", "google" ];
          keyword = "datadrivenmarketing";
          url = "https://www.thinkwithgoogle.com/marketing-strategies/data-and-measurement/data-driven-marketing-strategy/";

}
{
   name = "Advanced Google Analytics";
          tags = [ "googleanalytics", "course", "advanced" ];
          keyword = "gaadvancedcourse";
          url = "https://analytics.google.com/analytics/academy/course/7?authuser=1";

}
{
   name = "Google Tag Manager Fundamentals";
          tags = [ "googletagmanager", "course", "fundamentals" ];
          keyword = "gtmfundamentals";
          url = "https://analytics.google.com/analytics/academy/course/5?authuser=1";

}
{
   name = "Remarketing audiences you create - Analytics Help";
          tags = [ "googleanalytics", "remarketing", "help" ];
          keyword = "garemarketing";
          url = "https://support.google.com/analytics/answer/2611820?visit_id=637570295387160175-2120134827&rd=1#zippy=%2Cin-this-article";

}
{
   name = "Google Analytics Community";
          tags = [ "googleanalytics", "community", "help" ];
          keyword = "gacommunity";
          url = "https://support.google.com/analytics/community?hl=en&ctx=lithium";

}
{
   name = "Overview of Audience reports - Analytics Help";
          tags = [ "googleanalytics", "reports", "audience" ];
          keyword = "gaaudiencereports";
          url = "https://support.google.com/analytics/answer/1012034?hl=en#zippy=%2Cin-this-article";

}
{
   name = "Traffic source dimensions - Analytics Help";
          tags = [ "googleanalytics", "traffic", "dimensions" ];
          keyword = "gatrafficdimensions";
          url = "https://support.google.com/analytics/answer/1033173?hl=en";

}
{
   name = "Analyze channel contribution with Multi-Channel Funnels - Analytics Help";
          tags = [ "googleanalytics", "multichannel", "funnels" ];
          keyword = "gamultichannelfunnels";
          url = "https://support.google.com/analytics/answer/1191204?hl=en";

}
{
   name = "Exit Rate vs. Bounce Rate - Analytics Help";
          tags = [ "googleanalytics", "metrics", "bouncerate" ];
          keyword = "gaexitbounce";
          url = "https://support.google.com/analytics/answer/2525491?hl=en";

}
{
   name = "Best Practices for collecting campaign data with custom URLs - Analytics Help";
          tags = [ "googleanalytics", "campaigns", "urls" ];
          keyword = "gacampaignurls";
          url = "https://support.google.com/analytics/answer/1037445?hl=en";

}
{
   name = "Navigating full reports: Part 1 - Analytics Help";
          tags = [ "googleanalytics", "reports", "navigation" ];
          keyword = "ganavigatingreports";
          url = "https://support.google.com/analytics/answer/6383012?hl=en";

}
{
   name = "Google Tag Manager vs Google Analytics: Fully Explained (2020)";
          tags = [ "googletagmanager", "googleanalytics", "comparison" ];
          keyword = "gtmvga";
          url = "https://www.analyticsmania.com/post/google-tag-manager-vs-google-analytics/";

}
{
   name = "[GA4] Implementation guide for Google Tag Manager - Analytics Help";
          tags = [ "googleanalytics", "ga4", "googletagmanager" ];
          keyword = "ga4gtm";
          url = "https://support.google.com/analytics/answer/10270783?hl=en&ref_topic=10270831#zippy=%2Cin-this-article";

}
{
   name = "linux - What do ALSA devices like \"hw:0,0\" mean? How do I figure out which to use? - Super User";
          tags = [ "linux", "audio", "alsa" ];
          keyword = "alsadevices";
          url = "https://superuser.com/questions/53957/what-do-alsa-devices-like-hw0-0-mean-how-do-i-figure-out-which-to-use";

}
{
   name = "Bit Perfect Audio from Linux | Headphone Reviews and Discussion - Head-Fi.org";
          tags = [ "linux", "audio", "headphones" ];
          keyword = "bitperfectaudio";
          url = "https://www.head-fi.org/threads/bit-perfect-audio-from-linux.561961/#post-7596268";

}
{
   name = "Linux man pages online";
          tags = [ "linux", "documentation", "manpages" ];
          keyword = "linuxmanpages";
          url = "https://man7.org/linux/man-pages/index.html";

}
{
   name = "about - awesome window manager";
          tags = [ "linux", "windowmanager", "awesome" ];
          keyword = "awesomewm";
          url = "https://awesomewm.org/";

}
{
   name = "[How To] Make Linux sound GREAT! - Contributions / Tutorials - Manjaro Linux Forum";
          tags = [ "linux", "audio", "manjaro" ];
          keyword = "linuxsoundgreat";
          url = "https://forum.manjaro.org/t/how-to-make-linux-sound-great/146143";

}
{
   name = "R 4 DataScience";
          tags = [ "r", "datascience", "programming" ];
          keyword = "r4ds";
          url = "http://r4ds.had.co.nz/";

}
{
   name = "R 4 Data Science: Exercise Solutions";
          tags = [ "r", "datascience", "exercises" ];
          keyword = "r4dsexercises";
          url = "https://jrnold.github.io/r4ds-exercise-solutions/exploratory-data-analysis.html#variation";

}
{
   name = "The tidyverse style guide";
          tags = [ "r", "tidyverse", "styleguide" ];
          keyword = "tidyversestyle";
          url = "https://style.tidyverse.org/";

}
{
   name = "YaRrr! The Pirate’s Guide to R";
          tags = [ "r", "guide", "programming" ];
          keyword = "yarrr";
          url = "https://bookdown.org/ndphillips/YaRrr/who-is-this-book-for.html";

}
{
   name = "R Coding Style Best Practices";
          tags = [ "r", "codingstyle", "bestpractices" ];
          keyword = "rcodingstyle";
          url = "https://www.datanovia.com/en/blog/r-coding-style-best-practices/";

}
{
   name = "Colors (ggplot2)";
          tags = [ "r", "ggplot2", "colors" ];
          keyword = "ggplot2colors";
          url = "http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/";

}
{
   name = "A Grammar of Animated Graphics • gganimate";
          tags = [ "r", "ggplot2", "animation" ];
          keyword = "gganimate";
          url = "https://gganimate.com/";

}
{
   name = "A Layered Grammar of Graphics - layered-grammar.pdf";
          tags = [ "r", "graphics", "theory" ];
          keyword = "layeredgrammar";
          url = "http://vita.had.co.nz/papers/layered-grammar.pdf";

}
{
   name = "ggplot2: Elegant Graphics for Data Analysis";
          tags = [ "r", "ggplot2", "book" ];
          keyword = "ggplot2book";
          url = "https://ggplot2-book.org/";

}
{
   name = "Graphs";
          tags = [ "r", "graphics" ];
          keyword = "rgraphs";
          url = "http://www.cookbook-r.com/Graphs/";

}
{
   name = "Top 50 ggplot2 Visualizations - The Master List (With Full R Code)";
          tags = [ "r", "ggplot2", "visualizations" ];
          keyword = "ggplot2visualizations";
          url = "http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html";

}
{
   name = "R Color Styles";
          tags = [ "r", "colors", "style" ];
          keyword = "rcolorstyles";
          url = "https://bootstrappers.umassmed.edu/bootstrappers-courses/pastCourses/rCourse_2016-04/Additional_Resources/Rcolorstyle.html#named-colors";

}
{
   name = "Laying out multiple plots on a page";
          tags = [ "r", "plots", "layout" ];
          keyword = "rplotlayout";
          url = "https://cran.r-project.org/web/packages/egg/vignettes/Ecosystem.html";

}
{
   name = "Rcolor.pdf";
          tags = [ "r", "colors", "pdf" ];
          keyword = "rcolorpdf";
          url = "http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf";

}
{
   name = "R Linear Regression Tutorial - Door to master its working! - DataFlair";
          tags = [ "r", "linearregression", "tutorial" ];
          keyword = "rlinearregression";
          url = "https://data-flair.training/blogs/r-linear-regression-tutorial/";

}
{
   name = "Pluralsight Courses";
          tags = [ "education", "courses", "pluralsight" ];
          keyword = "pluralsightcourses";
          url = "https://www.pluralsight.com/product/skills?utm_term=&aid=701j0000002BGhbAAG&promo=&oid=&utm_source=branded&utm_medium=digital_paid_search_google&utm_campaign=ISR_Brand_E&utm_content=&gclid=Cj0KCQjwjcfzBRCHARIsAO-1_OoshWH8jjBkFIP3GPyARo9Fj1XlHKTmDeRx90GJ9-ZbPegBvLkZBzoaAlfXEALw_wcB";

}
{
   name = "DevOps: The Big Picture | Pluralsight";
          tags = [ "devops", "course", "pluralsight" ];
          keyword = "devopsbigpicture";
          url = "https://app.pluralsight.com/player?course=devops-big-picture&author=richard-seroter&name=24caaa04-2932-4633-abd0-b0cd4de0fc7c&clip=0&mode=live";

}
{
   name = "Improving your listening skills";
          tags = [ "softskills", "listening", "linkedinlearning" ];
          keyword = "improvinglistening";
          url = "https://www.linkedin.com/learning/improving-your-listening-skills-19238090/improving-your-listening-skills?u=0";

}
{
   name = "Getting started in building your product roadmap";
          tags = [ "productmanagement", "roadmap", "linkedinlearning" ];
          keyword = "productroadmap";
          url = "https://www.linkedin.com/learning/product-management-building-a-product-roadmap/getting-started-in-building-your-product-roadmap?u=0";

}
{
   name = "Become a product manager";
          tags = [ "productmanagement", "career", "linkedinlearning" ];
          keyword = "becomepm";
          url = "https://www.linkedin.com/learning/transitioning-to-product-management/become-a-product-manager-21968627?u=0";

}
{
   name = "Daily living as a leader";
          tags = [ "leadership", "softskills", "linkedinlearning" ];
          keyword = "dailyleadership";
          url = "https://www.linkedin.com/learning/20-habits-of-executive-leadership/daily-living-as-a-leader?save=true&u=0";

}
{
   name = "https://www.linkedin.com/learning/the-3-minute-rule-say-less-to-get-more/say-less-to-get-more?u=0";
          tags = [ "communication", "linkedinlearning" ];
          keyword = "3minuterule";
          url = "https://www.linkedin.com/learning/the-3-minute-rule-say-less-to-get-more/say-less-to-get-more?u=0";

}
{
   name = "My Path Dashboard | WorldQuant University";
          tags = [ "education", "finance", "quant" ];
          keyword = "wqumypath";
          url = "https://learn.wqu.edu/my-path";

}
{
   name = "WORTHBUY Stainless Steel Thermal Insulation Lunch Box With Spoon Student Office Works Bento Box Seal Leak Proof Food Containers - AliExpress";
          tags = [ "shopping", "kitchenware" ];
          keyword = "worthbuylunchbox";
          url = "https://www.aliexpress.com/item/1005006317423599.html?spm=a2g0o.productlist.main.5.1d89VSTVVSTVSi&algo_pvid=f95613d9-2ee5-4358-83f4-c7a12c19f9ff&algo_exp_id=f95613d9-2ee5-4358-83f4-c7a12c19f9ff-2&pdp_npi=4%40dis%21ILS%2192.50%2131.82%21%21%21174.92%2160.17%21%40211b801817061835842476814e10c1%2112000036829197702%21sea%21IL%21173306932%21&curPageLogUid=Di0NEAyu7XRM&utparam-url=scene%3Asearch%7Cquery_from%3A";

}
{
   name = "Rubik's cube solver app - Search";
          tags = [ "rubikscube", "solver", "app" ];
          keyword = "rubikscubesolver";
          url = "https://www.bing.com/search?q=Rubik%27s+cube+solver+app&qs=ds&form=CONVAJ&showconv=0";

}
{
   name = "> How to solve the Rubik's Cube - Beginners Method";
          tags = [ "rubikscube", "tutorial", "beginners" ];
          keyword = "rubikscubebeginner";
          url = "https://ruwix.com/the-rubiks-cube/how-to-solve-the-rubiks-cube-beginners-method/";

}
{
   name = "> Cubing Terminology - Abbreviations and Commonly Used Expressions";
          tags = [ "rubikscube", "terminology" ];
          keyword = "rubikscubeterms";
          url = "https://ruwix.com/the-rubiks-cube/cubing-terminology-abbreviations-commonly-used-expressions/";

}
{
   name = "> Different Rubik's Cube Solving Methods - Ruwix";
          tags = [ "rubikscube", "methods" ];
          keyword = "rubikscubemethods";
          url = "https://ruwix.com/the-rubiks-cube/different-rubiks-cube-solving-methods/";

}
{
   name = "> Rubik's Cube Algorithms - Ruwix";
          tags = [ "rubikscube", "algorithms" ];
          keyword = "rubikscubealgorithms";
          url = "https://ruwix.com/the-rubiks-cube/algorithm/";

}
{
   name = "> Online Rubik's Cube Solver";
          tags = [ "rubikscube", "solver", "online" ];
          keyword = "onlinerubikssolver";
          url = "https://rubiks-cube-solver.com/";

}
{
   name = "> Cubesolver";
          tags = [ "rubikscube", "solver", "app" ];
          keyword = "cubesolver";
          url = "https://cubesolver.app/en/tabs/home";

}
{
   name = "> מדריכים וכלים של פעמונים - paamonim";
          tags = [ "finance", "tools", "israel" ];
          keyword = "paamonimtools";
          url = "https://www.paamonim.org/he/%D7%9B%D7%9C%D7%99%D7%9D-%D7%95%D7%9E%D7%97%D7%A9%D7%91%D7%95%D7%A0%D7%99%D7%9D/";

}
{
   name = "> 11 צעדים איך להגיע לעצמאות כלכלית ופרישה מוקדמת | חתול פיננסי";
          tags = [ "finance", "financialindependence", "israel" ];
          keyword = "financialindependenceil";
          url = "https://moneyplan.co.il/11-%d7%a6%d7%a2%d7%93%d7%99%d7%9d-%d7%90%d7%99%d7%9a-%d7%9c%d7%94%d7%92%d7%99%d7%a2-%d7%9c%d7%a2%d7%a6%d7%9e%d7%90%d7%95%d7%aa-%d7%9b%d7%9c%d7%9b%d7%9c%d7%99%d7%aa-%d7%95%d7%a4%d7%a8%d7%99%d7%a9%d7%94/";

}
{
   name = "> ביטוח, פנסיה, גמל, חיסכון ושירותים פיננסיים | הראל ביטוח";
          tags = [ "finance", "insurance", "israel" ];
          keyword = "harelinsurance";
          url = "https://www.harel-group.co.il/Pages/default.aspx/";

}
{
   name = "> איך לחסוך כסף - 56 טיפים לחסכון | חתול פיננסי";
          tags = [ "finance", "savingmoney", "israel" ];
          keyword = "howtosavemoneyil";
          url = "https://moneyplan.co.il/%d7%90%d7%99%d7%9a-%d7%9c%d7%97%d7%a1%d7%95%d7%9a-%d7%9b%d7%a1%d7%a3/";

}
{
   name = "> חינוך פיננסי לילדים: תכינו את ילדכם להצלחה בעולם הפיננסי | חתול פיננסי";
          tags = [ "finance", "financialeducation", "kids", "israel" ];
          keyword = "financialeducationkidsil";
          url = "https://moneyplan.co.il/%d7%97%d7%99%d7%a0%d7%95%d7%9a-%d7%a4%d7%99%d7%a0%d7%a0%d7%a1%d7%99-%d7%9c%d7%99%d7%9c%d7%93%d7%99%d7%9d/";

}
{
   name = "> 12 עצות זהב לניהול תקציב הוצאות והכנסות וכלכלת משפחה | חתול פיננסי";
          tags = [ "finance", "budgeting", "familyfinance", "israel" ];
          keyword = "familybudgetil";
          url = "https://moneyplan.co.il/%d7%a0%d7%99%d7%94%d7%95%d7%9c-%d7%aa%d7%a7%d7%a6%d7%99%d7%91-%d7%94%d7%95%d7%a6%d7%90%d7%95%d7%aa-%d7%94%d7%9b%d7%a0%d7%a1%d7%95%d7%aa-%d7%9e%d7%a9%d7%a4%d7%97%d7%aa%d7%99-12-%d7%a2%d7%a6%d7%95%d7%aa/";

}
{
   name = "> קורס מקוון לניהול תקציב - paamonim";
          tags = [ "finance", "budgeting", "course", "israel" ];
          keyword = "budgetingcourseil";
          url = "https://www.paamonim.org/he/13223/";

}
{
   name = "free-programming-books/books/free-programming-books-langs.md at main · EbookFoundation/free-programming-books · GitHub";
          tags = [ "programming", "books", "free" ];
          keyword = "freeprogrammingbooks";
          url = "https://github.com/EbookFoundation/free-programming-books/blob/main/books/free-programming-books-langs.md#python";

}
{
   name = "Teach Yourself C in 24 Hours";
          tags = [ "cprogramming", "tutorial" ];
          keyword = "ctutorial24hours";
          url = "http://aelinik.free.fr/c/";

}
{
   name = "C Tutorial: Learn C Programming for Free";
          tags = [ "cprogramming", "tutorial", "free" ];
          keyword = "ctutorialfree";
          url = "https://www.tutorialspoint.com/cprogramming/index.htm";

}
{
   name = "Learning GNU C";
          tags = [ "cprogramming", "gnu", "book" ];
          keyword = "gnucbook";
          url = "https://www.nongnu.org/c-prog-book/online/";

}
{
   name = "The GNU C Reference Manual";
          tags = [ "cprogramming", "gnu", "manual" ];
          keyword = "gnucmanual";
          url = "https://www.gnu.org/software/gnu-c-manual/gnu-c-manual.html";

}
{
   name = "The Art of Unit Testing";
          tags = [ "softwaredevelopment", "testing", "book" ];
          keyword = "artofunittesting";
          url = "https://www.manning.com/books/the-art-of-unit-testing";

}
{
   name = "Department of Computer Science and Technology – Course pages 2018–19: Programming in C and C++ – Course materials";
          tags = [ "cprogramming", "cpp", "course" ];
          keyword = "cambridgec";
          url = "https://www.cl.cam.ac.uk/teaching/1819/ProgC/materials.html";

}
{
   name = "C Programming Reference Manual, Volume 1: Basic Implementation";
          tags = [ "cprogramming", "manual", "reference" ];
          keyword = "cprogrammingmanual";
          url = "https://public.support.unisys.com/aseries/docs/ClearPath-MCP-20.0/86002268-209/index.html";

}
{
   name = "CS 225 | Stack and Heap Memory";
          tags = [ "cprogramming", "memory", "cs" ];
          keyword = "cstackheap";
          url = "https://courses.grainger.illinois.edu/cs225/fa2023/resources/stack-heap/";

}
{
   name = "koz.ross/awesome-c: A curated list of awesome C frameworks, libraries, resources and other shiny things. Inspired by all the other awesome-... projects out there. - NotABug.org: Free code hosting";
          tags = [ "cprogramming", "awesome", "resources" ];
          keyword = "awesomec";
          url = "https://notabug.org/koz.ross/awesome-c";

}
{
   name = "Microsoft Word - Pointers.doc - pointers.pdf";
          tags = [ "cprogramming", "pointers", "pdf" ];
          keyword = "cpointers";
          url = "https://pdos.csail.mit.edu/6.828/2017/readings/pointers.pdf";

}
{
   name = "Building C projects";
          tags = [ "cprogramming", "build" ];
          keyword = "cprojects";
          url = "http://nethack4.org/blog/building-c.html";

}
{
   name = "C Programming - Wikibooks, open books for an open world";
          tags = [ "cprogramming", "wikibooks" ];
          keyword = "cprogrammingwikibooks";
          url = "https://en.wikibooks.org/wiki/C_Programming";

}
{
   name = "Introduction to \"Fun\" C (using GCC) · GitHub";
          tags = [ "cprogramming", "gcc", "github" ];
          keyword = "fungcc";
          url = "https://gist.github.com/eatonphil/21b3d6569f24ad164365";

}
{
   name = "Learning C with gdb - Blog - Recurse Center";
          tags = [ "cprogramming", "debugging", "gdb" ];
          keyword = "cgdb";
          url = "https://www.recurse.com/blog/5-learning-c-with-gdb";

}
{
   name = "What a C programmer should know about memory – Marek Vavrusa – Traveler in time and space";
          tags = [ "cprogramming", "memory" ];
          keyword = "cmemory";
          url = "https://marek.vavrusa.com/memory/";

}
{
   name = "8 gdb tricks you should know";
          tags = [ "debugging", "gdb", "tips" ];
          keyword = "gdbtricks";
          url = "https://blogs.oracle.com/linux/post/8-gdb-tricks-you-should-know";

}
{
   name = "10 C99 tricks | Guillaume Chereau Website";
          tags = [ "cprogramming", "c99", "tricks" ];
          keyword = "c99tricks";
          url = "https://gcher.com/posts/2015-02-13-c-tricks/";

}
{
   name = "Generic C Reference Counting";
          tags = [ "cprogramming", "memorymanagement" ];
          keyword = "creferencecounting";
          url = "https://nullprogram.com/blog/2015/02/17/";

}
{
   name = "How to Write Portable C Without Complicating Your Build";
          tags = [ "cprogramming", "portability", "build" ];
          keyword = "portablec";
          url = "https://nullprogram.com/blog/2017/03/30/";

}
{
   name = "What Every C Programmer Should Know About Undefined Behavior #1/3 - The LLVM Project Blog";
          tags = [ "cprogramming", "undefinedbehavior", "llvm" ];
          keyword = "cundefinedbehavior";
          url = "https://blog.llvm.org/2011/05/what-every-c-programmer-should-know.html";

}
{
   name = "Some dark corners of C - Google Slides";
          tags = [ "cprogramming", "slides", "advanced" ];
          keyword = "cdarkcorners";
          url = "https://docs.google.com/presentation/d/1h49gY3TSiayLMXYmRMaAEMl05FaJ-Z6jDOWOz3EsqqQ/edit?pli=1#slide=id.gaf50702c_0185";

}
{
   name = "Learn Touch Typing Free - TypingClub";
          tags = [ "typing", "education", "free" ];
          keyword = "typingclub";
          url = "https://www.typingclub.com/";

}
{
   name = "Vim cheatsheet - devhints";
          tags = [ "vim", "cheatsheet", "editor" ];
          keyword = "vimcheatsheet";
          url = "https://devhints.io/vim";

}
{
   name = "A Great Vim Cheat Sheet";
          tags = [ "vim", "cheatsheet", "editor" ];
          keyword = "vimgreatcheatsheet";
          url = "https://vimsheet.com/";

}
{
   name = "Vim Cheat Sheet";
          tags = [ "vim", "cheatsheet", "editor" ];
          keyword = "vimcheatsheetrtorr";
          url = "https://vim.rtorr.com/";

}
{
   name = "Lean Domain Search – Search for and register available domain names in seconds.";
          tags = [ "seo", "domains", "tools" ];
          keyword = "leandomainsearch";
          url = "https://leandomainsearch.com/";

}
{
   name = "Sample Size Calculator (Evan’s Awesome A/B Tools)";
          tags = [ "seo", "abtesting", "tools" ];
          keyword = "samplesizecalculator";
          url = "https://www.evanmiller.org/ab-testing/sample-size.html";

}
{
   name = "AeroFarms - An environmental champion, AeroFarms is leading the way to address our global food crisis by growing flavorful, healthy leafy greens in a sustainable and socially responsible way.";
          tags = [ "hydroponics", "agriculture", "verticalfarming" ];
          keyword = "aerofarms";
          url = "https://aerofarms.com/";

}
{
   name = "Green Automation";
          tags = [ "hydroponics", "automation", "agriculture" ];
          keyword = "greenautomation";
          url = "https://www.greenautomation.com/";

}
{
   name = "Viscon Hydroponics";
          tags = [ "hydroponics", "agriculture" ];
          keyword = "visconhydroponics";
          url = "https://www.visconhydroponics.eu/";

}
{
   name = "Automation and Robotics Used in Hydroponic System | IntechOpen";
          tags = [ "hydroponics", "automation", "robotics" ];
          keyword = "hydroponicautomation";
          url = "https://www.intechopen.com/books/urban-horticulture-necessity-of-the-future/automation-and-robotics-used-in-hydroponic-system";

}
{
   name = "AEssenseGrows Commercial Aeroponic Hydroponic Systems";
          tags = [ "hydroponics", "aeroponics", "commercial" ];
          keyword = "aessensegrows";
          url = "https://www.aessensegrows.com/";

}
{
   name = "Urban Crop Solutions";
          tags = [ "hydroponics", "verticalfarming" ];
          keyword = "urbancropsolutions";
          url = "https://urbancropsolutions.com/";

}
{
   name = "Farm.One - Weekly Salad Greens Subscription in NYC";
          tags = [ "hydroponics", "verticalfarming", "nyc" ];
          keyword = "farmone";
          url = "https://farm.one/";

}
{
   name = "Agriculture Solutions - Intelligent Growth Solutions";
          tags = [ "hydroponics", "agriculture", "solutions" ];
          keyword = "agriculturesolutions";
          url = "https://www.intelligentgrowthsolutions.com/use-cases-agri/#agri2";

}
{
   name = "Badia Farms";
          tags = [ "hydroponics", "verticalfarming" ];
          keyword = "badiafarms";
          url = "https://www.badiafarms.com/";

}
{
   name = "Sananbio US";
          tags = [ "hydroponics", "verticalfarming" ];
          keyword = "sananbious";
          url = "https://www.sananbious.com/";

}
{
   name = "\"We want to raise awareness on vertical farming in Italy\"";
          tags = [ "verticalfarming", "italy", "awareness" ];
          keyword = "verticalfarmingitaly";
          url = "https://www.hortidaily.com/article/9237129/we-want-to-raise-awareness-on-vertical-farming-in-italy/";

}
{
   name = "Vertical Farming | Lite+Fog | Germany";
          tags = [ "verticalfarming", "germany" ];
          keyword = "liteandfog";
          url = "https://www.liteandfog.com/";

}
{
   name = "VeggiTech – Advanced Farming";
          tags = [ "verticalfarming", "agriculture" ];
          keyword = "veggitech";
          url = "https://www.veggitech.com/";

}
{
   name = "AGRITECTURE";
          tags = [ "verticalfarming", "agriculture" ];
          keyword = "agritecture";
          url = "https://www.agritecture.com/";

}
{
   name = "Home - Association for Vertical Farming";
          tags = [ "verticalfarming", "association" ];
          keyword = "avf";
          url = "https://vertical-farming.net/";

}
{
   name = "Techno Farm™";
          tags = [ "verticalfarming", "agriculture" ];
          keyword = "technofarm";
          url = "https://technofarm.com/en/";

}
{
   name = "Indoor vertical farming (hydroponic) solutions | Urban Crop Solutions";
          tags = [ "verticalfarming", "hydroponics", "solutions" ];
          keyword = "urbancropsolutionshydro";
          url = "https://urbancropsolutions.com/solutions/";

}
{
   name = "AEtrium-SmartFarm - Fully Automated Vertical Stacked Aeroponic Farm";
          tags = [ "aeroponics", "automation", "verticalfarming" ];
          keyword = "aetriumsmarfarm";
          url = "https://www.aessensegrows.com/en/fresh/aetrium-smartfarm";

}
{
   name = "Wallfarm – Intelligent agriculture nutrient dosing";
          tags = [ "hydroponics", "automation", "nutrients" ];
          keyword = "wallfarm";
          url = "https://wallfarm.bio/";

}
{
   name = "FARMINOVA - Plant Factory";
          tags = [ "verticalfarming", "plantfactory" ];
          keyword = "farminova";
          url = "https://www.farminova.com/En";

}
{
   name = "CERT1763-Corporate brochure nieuw 8LR EN.pdf";
          tags = [ "agriculture", "brochure", "pdf" ];
          keyword = "certhonbrochure";
          url = "https://www.certhon.com/downloads/content/4093/8d88ad6a294f270/CERT1763-Corporate%20brochure%20nieuw%208LR%20EN.pdf";

}
{
   name = "Technology — Crop One";
          tags = [ "verticalfarming", "technology" ];
          keyword = "cropone";
          url = "https://cropone.ag/technology";

}
{
   name = "Voeks Inc. — Vertical Hydroponic Design";
          tags = [ "hydroponics", "design", "verticalfarming" ];
          keyword = "voeksinc";
          url = "https://www.voeksinc.com/vertical-hydroponic-design";

}
{
   name = "Vertical Farming Overview — HYVE® Indoor Farming Systems | Hydroponic Solutions";
          tags = [ "verticalfarming", "hydroponics", "systems" ];
          keyword = "hyvefarming";
          url = "https://growhyve.com/vertical-farming-overview";

}
{
   name = "Plant Spacing Calculator";
          tags = [ "gardening", "calculator", "plants" ];
          keyword = "plantspacing";
          url = "https://www.omnicalculator.com/construction/plants";

}
{
   name = "Sizing a hydroponic system | Growers Supply";
          tags = [ "hydroponics", "sizing", "guide" ];
          keyword = "hydroponicsizing";
          url = "https://growerssupply.wordpress.com/2016/05/31/sizing-a-hydroponic-system/";

}
{
   name = "Water Soluble Fertilizer Calculator";
          tags = [ "gardening", "fertilizer", "calculator" ];
          keyword = "fertilizercalculator";
          url = "https://www.omnicalculator.com/construction/water-soluble-fertilizer";

}
{
   name = "Alan Bartlett and Sons | Quality Parsnips";
          tags = [ "agriculture", "produce", "parsnips" ];
          keyword = "alanbartlett";
          url = "https://alanbartlettandsons.co.uk/our-produce/parsnips/";

}
{
   name = "Contact Us - Burgess Farm Produce";
          tags = [ "agriculture", "produce", "contact" ];
          keyword = "burgessfarm";
          url = "http://www.burgessfarmproduce.co.uk/contact-us/";

}
{
   name = "Contact - British Organic Carrots";
          tags = [ "agriculture", "organic", "carrots" ];
          keyword = "britishorganiccarrots";
          url = "http://britishorganiccarrots.co.uk/contact/";

}
{
   name = "Carrots - Strawson LTD";
          tags = [ "agriculture", "carrots" ];
          keyword = "strawsoncarrots";
          url = "https://strawsons.com/carrots/";

}
{
   name = "Contact Us – Kettle Produce";
          tags = [ "agriculture", "produce", "contact" ];
          keyword = "kettleproduce";
          url = "http://kettle.co.uk/contact-us/";

}
{
   name = "Roots";
          tags = [ "agriculture", "produce", "roots" ];
          keyword = "huntapacroots";
          url = "http://www.huntapac.co.uk/roots/";

}
{
   name = "Carrots";
          tags = [ "agriculture", "carrots", "prepared" ];
          keyword = "alfredgpearcecarrots";
          url = "https://www.alfredgpearce.co.uk/prepared-vegetables/carrots/";

}
{
   name = "Products | Freshgro";
          tags = [ "agriculture", "produce", "products" ];
          keyword = "freshgroproducts";
          url = "https://www.freshgro.co.uk/category/products/";

}
{
   name = "RRW Bartlett";
          tags = [ "agriculture", "produce" ];
          keyword = "rrwbartlett";
          url = "https://rrwbartlett.co.uk/our-produce/";

}
{
   name = "Carrot grower — Hobson Farming | British carrot grower and farmer";
          tags = [ "agriculture", "carrots", "farming" ];
          keyword = "hobsonfarming";
          url = "https://www.hobsonfarming.co.uk/carrot-grower";

}
{
   name = "http://www.abrey-farms.co.uk/carrots.asp";
          tags = [ "agriculture", "carrots" ];
          keyword = "abreyfarmscarrots";
          url = "http://www.abrey-farms.co.uk/carrots.asp";

}
{
   name = "(1) LinkedIn";
          tags = [ "linkedin", "socialmedia" ];
          keyword = "linkedinabreyfarms";
          url = "https://www.linkedin.com/sharing/share-offsite/?url=http%3A%2F%2Fwww.abrey-farms.co.uk%2Fcarrots.asp";

}
{
   name = "Vegatable Producer Bromham, Wiltshire, Bunched Carrots";
          tags = [ "agriculture", "carrots", "producer" ];
          keyword = "pagetsproduce";
          url = "https://www.pagetsproduce.co.uk/availability.html";

}
{
   name = "BridgeFarm Group";
          tags = [ "agriculture", "plants" ];
          keyword = "bridgefarmgroup";
          url = "https://www.bridgefarmgroup.co.uk/products/outdoor-plants/";

}
{
   name = "Gallery - Suffolk Produce Ltd";
          tags = [ "agriculture", "gallery" ];
          keyword = "suffolkproducegallery";
          url = "http://www.suffolkproduce.co.uk/gallery.html";

}
{
   name = "Coming Soon Page";
          tags = [ "agriculture", "website" ];
          keyword = "benzies";
          url = "https://www.benzies.co.uk/";

}
{
   name = "Carrots";
          tags = [ "agriculture", "carrots" ];
          keyword = "poskittcarrots";
          url = "https://poskittcarrots.co.uk/farm/carrots";

}
{
   name = "Our products | Dutch Carrot Group";
          tags = [ "agriculture", "carrots", "products" ];
          keyword = "dutchcarrotgroup";
          url = "https://www.dutchcarrotgroup.nl/our-products?lang=en";

}
{
   name = "HEEGSMA BV, Vegetables, edible roots and tubers, Fruits and vegetables - import-export, Onions, on EUROPAGES.";
          tags = [ "agriculture", "vegetables", "importexport" ];
          keyword = "heegsmabv";
          url = "https://www.europages.co.uk/HEEGSMA-BV/NLD123014-00101.html";

}
{
   name = "Australian Exporters - Searching for: \"Carrot\"";
          tags = [ "agriculture", "australia", "exporters" ];
          keyword = "australiancarrotsexporters";
          url = "http://www.australianexporters.net/AExportersSearch/?term=carrot";

}
{
   name = "Arahura Farms - Certified organic carrot growers/packers - Australian Exporters";
          tags = [ "agriculture", "organic", "carrots", "australia" ];
          keyword = "arahurafarms";
          url = "http://www.australianexporters.net/companyID48400.htm";

}
{
   name = "Field Fresh Tasmania - Onions, carrots - Australian Exporters";
          tags = [ "agriculture", "onions", "carrots", "australia" ];
          keyword = "fieldfreshtasmania";
          url = "http://www.australianexporters.net/companyID2601.htm";

}
{
   name = "Geoffrey Thompson & Growers Co-operative Co Pty Ltd - Pears, grapes, apples, carrots, citrus fruits - Australian Exporters";
          tags = [ "agriculture", "fruits", "vegetables", "australia" ];
          keyword = "geoffreythompson";
          url = "http://www.australianexporters.net/companyID2875.htm";

}
{
   name = "L & G Gazzola & Sons Pty Ltd - Celery, lettuce, asian vegetables, broccolli, carrots, parsnips - Australian Exporters";
          tags = [ "agriculture", "vegetables", "australia" ];
          keyword = "gazzolaandsons";
          url = "http://www.australianexporters.net/companyID3922.htm#contactdetails";

}
{
   name = "Patane Produce (WA) Pty Ltd - Vegetables, primarily Carrots, Onions, Potatoes and Broccoli - Australian Exporters";
          tags = [ "agriculture", "vegetables", "australia" ];
          keyword = "pataneproduce";
          url = "http://www.australianexporters.net/companyID8669.htm";

}
{
   name = "Australian Suppliers Directory - Austrade";
          tags = [ "australia", "suppliers", "directory" ];
          keyword = "austradesuppliers";
          url = "https://www.austrade.gov.au/SupplierDetails.aspx?ORGID=ORG0000016388&folderid=1736";

}
{
   name = "Mehr über HLB - HLB research and consultancy in agriculture";
          tags = [ "agriculture", "research", "consultancy" ];
          keyword = "hlbagriculture";
          url = "https://www.hlbbv.nl/index.php/de/";

}
{
   name = "Die AMI | AMI | Über uns | AMI | natürlich informiert";
          tags = [ "agriculture", "germany", "information" ];
          keyword = "amiinformiert";
          url = "https://www.ami-informiert.de/ueber-die-ami";

}
{
   name = "Hazera_2018-19-Catalogue.pdf";
          tags = [ "agriculture", "seeds", "catalogue" ];
          keyword = "hazeracatalogue";
          url = "https://static1.squarespace.com/static/5ea63e770ba57d40620339d9/t/5ea76def25ab4e20b23703bf/1588030991990/Hazera_2018-19-Catalogue.pdf";

}
{
   name = "Agriculture companies in Belgium";
          tags = [ "agriculture", "belgium", "companies" ];
          keyword = "belgiumagriculture";
          url = "https://companylist.org/Belgium/Agriculture/";

}
{
   name = "Fresh Carrots companies in the United States";
          tags = [ "agriculture", "carrots", "usa" ];
          keyword = "usfreshcarrots";
          url = "https://companylist.org/United_States/Agriculture/Fresh_Vegetables/Fresh_Carrots/";

}
{
   name = "Veco BV - Parisian carrots";
          tags = [ "agriculture", "carrots", "netherlands" ];
          keyword = "vecoparisiancarrots";
          url = "https://www.vecobv.nl/en/";

}
{
   name = "World Markets for Organic Fruit and Vegetables";
          tags = [ "agriculture", "organic", "markets" ];
          keyword = "organicfruitvegmarkets";
          url = "http://www.fao.org/3/y1669e/y1669e00.htm#Contents";

}
{
   name = "New Age Provisions Webinar - Thank You | Freight Farms";
          tags = [ "verticalfarming", "webinar", "freightfarms" ];
          keyword = "freightfarmswebinar";
          url = "https://www.freightfarms.com/new-age-provisions-webinar-thank-you?utm_campaign=Nov.%202020%20-%20New%20Age%20Provisions%20Webinar&utm_medium=email&_hsmi=100141007&_hsenc=p2ANqtz-9farkncVr9_JC_wdbY4yOCRr_Iyvw5r76Qn37rFE-bae8QpX1-gGe-Z0WLZH1je72BZ0tWSknxT1goiA2p0sG-MTM5HQ&utm_content=100141007&utm_source=hs_email";

}
{
   name = "Opportunities & Risks - Idaho University";
          tags = [ "mushrooms", "agriculture", "research" ];
          keyword = "shroomsopportunities";
          url = "https://www.extension.uidaho.edu/publishing/pdf/CIS/CIS1077.pdf";

}
{
   name = "Mushroom_12_DEF.indd - i0522e.pdf";
          tags = [ "mushrooms", "pdf", "agriculture" ];
          keyword = "mushroompdf";
          url = "http://www.fao.org/3/i0522e/i0522e.pdf";

}
{
   name = "אירגון מידע לפי עיר (1).xlsx - Google Sheets";
          tags = [ "slums", "data", "googlesheets" ];
          keyword = "slumsdata";
          url = "https://docs.google.com/spreadsheets/d/1c0dZY-pqTWdcSgTpI7chJR524f1jNVKr/edit#gid=71517364";

}
{
   name = "Réglementation relative à l’occupation et à l’entretien des bâtiments - Outils de réglementation - Ministère des Affaires municipales et de l'Habitation";
          tags = [ "slums", "regulation", "housing" ];
          keyword = "housingregulation";
          url = "https://www.mamh.gouv.qc.ca/amenagement-du-territoire/guide-la-prise-de-decision-en-urbanisme/reglementation/reglementation-relative-a-loccupation-et-a-lentretien-des-batiments/";

}
{
   name = "Ministerium für Gehäuse at DuckDuckGo";
          tags = [ "slums", "housing", "government" ];
          keyword = "housingministry";
          url = "https://duckduckgo.com/?q=Ministerium+f%C3%BCr+Geh%C3%A4use&t=lm&atb=v158-1&ia=web";

}
{
   name = "Definition MoLGH: Ministerium der lokalen Regierung und Gehäuse - Ministry of Local Government and Housing";
          tags = [ "slums", "government", "housing" ];
          keyword = "molghdefinition";
          url = "https://www.abbreviationfinder.org/de/acronyms/molgh_ministry-of-local-government-and-housing.html";

}
{
   name = "Server Not Found";
          tags = [ "slums", "news" ];
          keyword = "servernotfound";
          url = "https://newsde.eu/2020/07/30/das-ministerium-sagte-die-menge-des-geldes-zu-loesen-das-gehaeuse-problem-der-behinderten/";

}
{
   name = "Ponte-Tower in Johannesburg: \"Afrikas gefährlichstes Hochhaus\" wird Touristenmagnet - ZDFheute";
          tags = [ "slums", "johannesburg", "architecture" ];
          keyword = "pontetower";
          url = "https://www.zdf.de/nachrichten/panorama/suedafrika-ponte-tower-johannesburg-touristenattraktion-100.html";

}
{
   name = "Institut der Stadtbaukunst – Ein Forum für Architektur und Städtebau";
          tags = [ "architecture", "urbanplanning", "institute" ];
          keyword = "stadtbaukunst";
          url = "https://www.stadtbaukunst.org/deutsch/staedtebaulehre/seminare/mythoshochhaus/index.html?tid=516&btid=69";

}
{
   name = "Die Zukunft der Städte: Jeder sechste Erdbewohner lebt im Slum - Sachbuch - FAZ";
          tags = [ "slums", "urbanization", "future" ];
          keyword = "futureofcities";
          url = "https://www.faz.net/aktuell/feuilleton/buecher/rezensionen/sachbuch/die-zukunft-der-staedte-jeder-sechste-erdbewohner-lebt-im-slum-1438571.html";

}
{
   name = "Die Slums von Madrid | Europa | DW | 03.09.2012";
          tags = [ "slums", "madrid", "europe" ];
          keyword = "madridslums";
          url = "https://www.dw.com/de/die-slums-von-madrid/a-16211944";

}
{
   name = "Was Architektur im Slum bewegen kann";
          tags = [ "slums", "architecture", "impact" ];
          keyword = "slumarchitecture";
          url = "https://www.oeaw.ac.at/detail/news/was-architektur-im-slum-bewegen-kann/";

}
{
   name = "Städtische Slums: Wie und warum sie entstehen";
          tags = [ "slums", "urbanplanning", "causes" ];
          keyword = "urbanslums";
          url = "https://www.greelane.com/geisteswissenschaften/erdkunde/massive-urban-slums-1435765/";

}
{
   name = "Mauer soll Jakarta schützen: Wie eine Millionenstadt im Meer versinkt - n-tv.de";
          tags = [ "jakarta", "urbanplanning", "climatechange" ];
          keyword = "jakartasinking";
          url = "https://www.n-tv.de/panorama/Wie-eine-Millionenstadt-im-Meer-versinkt-article21424103.html";

}
{
   name = "Time Tracking Software - Free Automated Time Tracker TimeCamp";
          tags = [ "productivity", "software", "timetracking" ];
          keyword = "timecamp";
          url = "https://www.timecamp.com/";

}
{
   name = "Google Translate";
          tags = [ "translation", "google" ];
          keyword = "googletranslate";
          url = "https://translate.google.com/?sl=auto&tl=de&text=Minist%C3%A8re%20des%20Affaires%20municipales%0Aet%20de%20l%27Habitation&op=translate";

}
{
   name = "Inkscape tutorial: Basic | Inkscape";
          tags = [ "design", "inkscape", "tutorial" ];
          keyword = "inkscapetutorial";
          url = "https://inkscape.org/doc/tutorials/basic/tutorial-basic.html";

}
{
   name = "Create word clouds – WordItOut";
          tags = [ "tools", "wordcloud", "design" ];
          keyword = "worditout";
          url = "https://worditout.com/word-cloud/create";

}
{
   name = "TagCrowd: create your own word cloud from any text";
          tags = [ "tools", "wordcloud", "design" ];
          keyword = "tagcrowd";
          url = "https://tagcrowd.com/";

}
{
   name = "Word Art - Edit - WordArt.com";
          tags = [ "tools", "wordart", "design" ];
          keyword = "wordart";
          url = "https://wordart.com/create";

}
{
   name = "GitHub - GeekMagicClock/smalltv-pro: PRO version of GeekMagic smalltv";
          tags = [ "github", "project", "tv" ];
          keyword = "smalltvpro";
          url = "https://github.com/GeekMagicClock/smalltv-pro?type%3D6%26list_name%3D%E6%9C%AA%E5%91%BD%E5%90%8D";

}
{
   name = "Start-Up Nation Finder";
          tags = [ "jobsearch", "startup", "israel" ];
          keyword = "startupnationfinder";
          url = "https://finder.startupnationcentral.org/";

}
{
   name = "סטארטאפ והון סיכון | גיקטיים";
          tags = [ "startup", "venturecapital", "israel" ];
          keyword = "geektime";
          url = "https://www.geektime.co.il/category/startup/";

}
{
   name = "GCC - Gvahim Career Center - Gvahim";
          tags = [ "jobsearch", "careercenter", "israel" ];
          keyword = "gvahimcareercenter";
          url = "https://gvahim.org.il/gavhim-career-center/";

}
{
   name = "Israel Companies · Bessemer Venture Partners";
          tags = [ "venturecapital", "israel", "companies" ];
          keyword = "bvpcompanies";
          url = "https://www.bvp.com/israelcompanies#israel";

}
{
   name = "Home | Giza Venture Capital";
          tags = [ "venturecapital", "israel" ];
          keyword = "gizavc";
          url = "https://www.gizavc.com/";

}
{
   name = "Sequoia - Companies";
          tags = [ "venturecapital", "companies" ];
          keyword = "sequoiacompanies";
          url = "https://www.sequoiacap.com/israel/companies/";

}
{
   name = "YL Ventures - From Seed to Lead";
          tags = [ "venturecapital", "cybersecurity" ];
          keyword = "ylventures";
          url = "https://www.ylventures.com/";

}
{
   name = "Viola - Portfolio";
          tags = [ "venturecapital", "portfolio" ];
          keyword = "violaportfolio";
          url = "https://www.viola-group.com/portfolio/?industry=&fund=&search=&activeexit=Active&thePage=1";

}
{
   name = "Israel Companies · Bessemer Venture Partners";
          tags = [ "venturecapital", "israel", "companies" ];
          keyword = "bvpcompanies";
          url = "https://www.bvp.com/israelcompanies";

}
{
   name = "TLV Partners";
          tags = [ "venturecapital", "israel" ];
          keyword = "tlvpartners";
          url = "https://www.tlv.partners/#COMPANIES";

}
{
   name = "הפרודקטיבית – על ניהול מוצר, חיפוש עבודה והתובנות שביניהם";
          tags = [ "productmanagement", "jobsearch", "blog" ];
          keyword = "haproductivit";
          url = "https://haproductivit.com/";

}
{
   name = "Mind the Product - Conferences, training, and content for the world’s largest community of product managers, designers, and developers.";
          tags = [ "productmanagement", "community", "training" ];
          keyword = "mindtheproduct";
          url = "https://www.mindtheproduct.com/";

}
{
   name = "Create Magazine | בית הספר לחווית משתמש, UX, ניהול מוצר וחווית משתמש";
          tags = [ "ux", "productmanagement", "magazine" ];
          keyword = "createmagazine";
          url = "https://www.createmagazine.co.il/";

}
{
   name = "The Ultimate Guide to 37 Product Management Prioritization Frameworks";
          tags = [ "productmanagement", "frameworks", "guide" ];
          keyword = "pmframeworks";
          url = "https://www.productplan.com/product-management-frameworks/";

}
{
   name = "The Ultimate Product Management Framework to Help You Build the Right Product | Infinity";
          tags = [ "productmanagement", "framework", "guide" ];
          keyword = "ultimatepmframework";
          url = "https://startinfinity.com/product-management-framework";

}
{
   name = "How To Optimize Your LinkedIn Profile for Product Manager Recruiters";
          tags = [ "linkedin", "jobsearch", "productmanagement" ];
          keyword = "linkedinpmoptimize";
          url = "https://dailyproductprep.com/blog/how-to-optimize-your-linked-profile-for-product-manager-recruiters";

}
{
   name = "Wix.com Tel Aviv";
          tags = [ "jobs", "telaviv", "tech" ];
          keyword = "wixjobs";
          url = "https://www.wix.com/jobs/locations/tel-aviv";

}
{
   name = "Amazing Job Opportunities @ Fiverr.com";
          tags = [ "jobs", "telaviv", "freelance" ];
          keyword = "fiverrjobs";
          url = "https://www.fiverr.com/jobs/offices/tlv";

}
{
   name = "Tel Aviv, Israel | Amazon.jobs";
          tags = [ "jobs", "telaviv", "amazon" ];
          keyword = "amazonjobs";
          url = "https://jobs-us-west.amazon.com/en/locations/tel-aviv-israel";

}
{
   name = "Google Careers";
          tags = [ "jobs", "telaviv", "google" ];
          keyword = "googlecareers";
          url = "https://careers.google.com/jobs/results/?company=Google&company=Google%20Fiber&company=YouTube&employment_type=FULL_TIME&hl=en_US&jlo=en_US&location=Israel&q=&sort_by=relevance";

}
{
   name = "Facebook Job Openings | Facebook Careers | Facebook Careers";
          tags = [ "jobs", "telaviv", "facebook" ];
          keyword = "facebookjobs";
          url = "https://www.facebook.com/careers/jobs/?offices[0]=Tel%20Aviv%2C%20Israel";

}
{
   name = "Secret Tel Aviv Jobs - Product Manager";
          tags = [ "jobs", "telaviv", "productmanager" ];
          keyword = "secrettelavivpm";
          url = "https://jobs.secrettelaviv.com/list/category/product-manager/";

}
{
   name = "Riskified Careers";
          tags = [ "jobs", "telaviv", "tech" ];
          keyword = "riskifiedcareers";
          url = "https://www.riskified.com/careers/";

}
{
   name = "Jobs at Moovit";
          tags = [ "jobs", "telaviv", "tech" ];
          keyword = "moovitjobs";
          url = "https://www.comeet.com/jobs/moovit/63.007";

}
{
   name = "WalkMe Jobs : Open Positions - WalkMe™";
          tags = [ "jobs", "telaviv", "tech" ];
          keyword = "walkmejobs";
          url = "https://www.walkme.com/careers/careers_list/?region=emea";

}
{
   name = "Careers | Strategy& Israel";
          tags = [ "jobs", "telaviv", "consulting" ];
          keyword = "strategyandcareers";
          url = "https://www.strategyand.pwc.com/il/en/careers.html";

}
{
   name = "19 examples of STAR interview questions (plus how to answer them using STAR method)";
          tags = [ "interviews", "star", "career" ];
          keyword = "starinterview";
          url = "https://www.theladders.com/career-advice/a-guide-to-the-star-method";

}
{
   name = "30 Behavioral Interview Questions to Prepare For (with Example Answers) | Indeed.com";
          tags = [ "interviews", "behavioral", "career" ];
          keyword = "behavioralinterview";
          url = "https://www.indeed.com/career-advice/interviewing/most-common-behavioral-interview-questions-and-answers";

}
{
   name = "12 Difficult Behavioral Interview Questions - InterviewPenguin.com";
          tags = [ "interviews", "behavioral", "difficult" ];
          keyword = "difficultbehavioral";
          url = "https://interviewpenguin.com/behavioral-interview-questions-and-answers/";

}
{
   name = "4 Simple Strategies on How to Overcome Job Interview Stress";
          tags = [ "interviews", "stress", "tips" ];
          keyword = "interviewstress";
          url = "https://interviewpenguin.com/how-to-overcome-interview-nerves/";

}
{
   name = "15 Most Common Interview Questions and Answers for 2020";
          tags = [ "interviews", "commonquestions" ];
          keyword = "commoninterviewquestions";
          url = "https://interviewpenguin.com/interview-questions-and-answers/";

}
{
   name = "How to Respond to Interview Questions About Teamwork";
          tags = [ "interviews", "teamwork", "softskills" ];
          keyword = "teamworkinterview";
          url = "https://www.thebalancecareers.com/how-to-respond-to-interview-questions-about-teamwork-2061100";

}
{
   name = "Interview Question: \"What Do You Hope to Accomplish Here?\"";
          tags = [ "interviews", "careergoals" ];
          keyword = "accomplishhere";
          url = "https://www.thebalancecareers.com/what-can-we-expect-from-you-in-the-first-60-days-2061099";

}
{
   name = "Getting Started with Amazon Web Services (AWS)";
          tags = [ "aws", "cloud", "gettingstarted" ];
          keyword = "awsgettingstarted";
          url = "https://aws.amazon.com/getting-started/?sc_channel=em&sc_campaign=wlcm&sc_publisher=aws&sc_medium=em_wlcm_1&sc_detail=wlcm_1d&sc_content=other&sc_country=global&sc_geo=global&sc_category=mult&ref_=pe_1679150_261538020";

}
{
   name = "Fundamental Cloud Concepts for AWS - Pluralsight";
          tags = [ "aws", "cloud", "pluralsight" ];
          keyword = "awscloudconcepts";
          url = "https://app.pluralsight.com/courses/dfafd3ec-a172-4f7c-9fa2-7a230f96ec3c/table-of-contents";

}
{
   name = "AWS Cloud Practitioner Essentials | AWS Training & Certification";
          tags = [ "aws", "certification", "training" ];
          keyword = "awscloudpractitioner";
          url = "https://www.aws.training/Details/eLearning?id=60697";

}
{
   name = "Overview of Amazon Web Services - AWS Whitepaper - aws-overview.pdf";
          tags = [ "aws", "whitepaper", "overview" ];
          keyword = "awsoverviewpdf";
          url = "https://docs.aws.amazon.com/whitepapers/latest/aws-overview/aws-overview.pdf";

}
{
   name = "Overview of Amazon Web Services - aws-overview.pdf";
          tags = [ "aws", "whitepaper", "overview" ];
          keyword = "awsoverviewpdf2";
          url = "https://d0.awsstatic.com/whitepapers/aws-overview.pdf";

}
{
   name = "21 Important List of AWS Services you must know | DEVOPS MY WAY";
          tags = [ "aws", "services", "devops" ];
          keyword = "awsserviceslist";
          url = "https://devopsmyway.com/list-of-aws-services/";

}
{
   name = "AWS 101: Overview of Amazon Web Services";
          tags = [ "aws", "overview", "basics" ];
          keyword = "aws101";
          url = "https://www.sumologic.com/insight/aws/";

}
{
   name = "BCG - Case Library";
          tags = [ "consulting", "caseinterview", "bcg" ];
          keyword = "bcgcaselibrary";
          url = "https://icl.bcg.com/";

}
{
   name = "Math Training Prototype - Math Test";
          tags = [ "caseinterview", "math", "training" ];
          keyword = "casemath";
          url = "https://www.caseinterview.com/math/mathtest.php";

}
{
   name = "How to synthesize your findings | CaseCoach";
          tags = [ "caseinterview", "synthesis", "casecoach" ];
          keyword = "casesynthesis";
          url = "https://casecoach.com/courses/interview-prep-course-for-bcg/modules/learn-how-to-shape-and-communicate-your-answer-2/class/how-to-synthesize-your-findings-1/";

}
{
   name = "Exhibit Drills #1 | CaseCoach";
          tags = [ "caseinterview", "drills", "casecoach" ];
          keyword = "caseexhibitdrills";
          url = "https://casecoach.com/courses/interview-prep-course-for-bcg/modules/practice-practice-practice-3/class/exhibit-drills-1-2/";

}
{
   name = "RuTracker.org - ROCK";
          tags = [ "music", "download", "rock" ];
          keyword = "rutrackerrock";
          url = "https://rutracker.org/forum/viewforum.php?f=1698";

}
{
   name = "RuTracker.org - Electronic music (digitizing)";
          tags = [ "music", "download", "electronic" ];
          keyword = "rutrackerelectronic";
          url = "https://oodixxdcsthfjpmzpthnxt3kzu--rutracker-org.translate.goog/forum/viewforum.php?f=1754";

}
{
   name = "RuTracker.org - Electronic music (Hi-Res stereo)";
          tags = [ "music", "download", "hires", "electronic" ];
          keyword = "rutrackerhireselectronic";
          url = "https://rutracker.org/forum/viewforum.php?f=1893";

}
{
   name = "RuTracker.org - Music of different genres (Hi-Res stereo and multichannel music)";
          tags = [ "music", "download", "hires", "multichannel" ];
          keyword = "rutrackerhiresmultichannel";
          url = "https://rutracker.org/forum/viewforum.php?f=2512";

}
{
   name = "RuTracker.org - Rock music (Hi-Res stereo)";
          tags = [ "music", "download", "hires", "rock" ];
          keyword = "rutrackerhiresrock";
          url = "https://rutracker.org/forum/viewforum.php?f=1755";

}
{
   name = "RuTracker.org - Jazz and Blues (Hi-Res stereo)";
          tags = [ "music", "download", "hires", "jazz", "blues" ];
          keyword = "rutrackerhiresjazzblues";
          url = "https://rutracker.org/forum/viewforum.php?f=2302";

}
{
   name = "RuTracker.org - Digitized ALL";
          tags = [ "music", "download", "digitized" ];
          keyword = "rutrackerdigitized";
          url = "https://rutracker.org/forum/viewforum.php?f=2219";

}
{
   name = "MVGroup (Powered by Invision Power Board)";
          tags = [ "forum", "community" ];
          keyword = "mvgroup";
          url = "https://forums.mvgroup.org/";

}
{
   name = "CLAS all methods";
          tags = [ "baking", "bread" ];
          keyword = "brotgostclas";
          url = "https://brotgost.blogspot.com/2017/08/iii.html";

}
{
   name = "Pluralsight LinkedIn";
          tags = [ "pluralsight", "linkedin" ];
          keyword = "pluralsightlinkedin";
          url = "https://app.pluralsight.com/course-player?clipId=30e90fb9-a6c9-40ba-8dbf-50f39ddea77b";

}
{
   name = "Unicode Text Converter";
          tags = [ "tools", "textconverter", "unicode" ];
          keyword = "unicodetextconverter";
          url = "https://qaz.wtf/u/convert.cgi?text=goal-oriented";

}
{
   name = "LinkedIn Text Formatter » LinkedIn Makeover: LinkedIn Profile Optimization";
          tags = [ "linkedin", "tools", "formatter" ];
          keyword = "linkedinformatter";
          url = "https://www.linkedin-makeover.com/linkedin-text-formatter/";

}
{
   name = "Directions to Format Your LinkedIn Profile with Symbols / Bullets";
          tags = [ "linkedin", "tips", "symbols" ];
          keyword = "linkedinsymbols";
          url = "https://www.linkedin-makeover.com/tools/symbols/";

}
{
   name = "UTWS3 - Manual";
          tags = [ "audio", "manual", "headphones" ];
          keyword = "utws3manual";
          url = "http://fiio-instruction.fiio.net/UTWS3/UTWS3%20Quick_Start_Guide.pdf";

}
{
   name = "How to Get Users and Grow - Alex Schultz - CS183F - YouTube";
          tags = [ "marketing", "growth", "youtube" ];
          keyword = "getusersgrow";
          url = "https://www.youtube.com/watch?v=URiIsrdplbo";

}
{
   name = "Anna’s Archive";
          tags = [ "books", "archive", "resources" ];
          keyword = "annasarchive";
          url = "https://annas-archive.org/";

}
{
   name = "GNOME Shell Extensions";
          tags = [ "linux", "gnome", "extensions" ];
          keyword = "gnomeshellextensions";
          url = "https://extensions.gnome.org/";

}
{
   name = "R Tutorial for Beginners - Learn R Programming from Scratch - DataFlair";
          tags = [ "r", "tutorial", "beginners" ];
          keyword = "rtutorialbeginners";
          url = "https://data-flair.training/blogs/r-tutorials-home/";

}
{
   name = "Suchergebnisse";
          tags = [ "gardening", "seeds", "shop" ];
          keyword = "semillas";
          url = "https://www.semillas.de/cgi-bin/shop/shop.cgi";

}
{
   name = "Careers | Verbit AI transcriptions";
          tags = [ "jobs", "ai", "transcription" ];
          keyword = "verbitcareers";
          url = "https://verbit.ai/careers-listing/?vps=&career_location=Tel+Aviv%2C+Israel&career_position=";

}
{
   name = "31 Free Hi Res Audio Players [Windows Mac Linux Android iOS]";
          tags = [ "audio", "players", "hires" ];
          keyword = "hiresaudioplayers";
          url = "https://samplerateconverter.com/educational/audio-player";

}
{
   name = "Alerts - Open Trades | ClickCapital";
          tags = [ "finance", "trading", "alerts" ];
          keyword = "clickcapitalalerts";
          url = "https://www.clickcapital.io/alerts-open-trades";

}
{
   name = "טיפול במבוגרים עם הפרעת קשב וריכוז (ADHD) - קוג פאן";
          tags = [ "health", "adhd", "therapy" ];
          keyword = "adhdtherapy";
          url = "https://cogfun.co.il/%d7%98%d7%99%d7%a4%d7%95%d7%9c-%d7%91%d7%9e%d7%91%d7%95%d7%92%d7%a8%d7%99%d7%9d-%d7%a2%d7%9d-%d7%94%d7%a4%d7%a8%d7%a2%d7%aa-%d7%a7%d7%a9%d7%91-%d7%95%d7%a8%d7%99%d7%9b%d7%95%d7%96-adhd/";

}
{
   name = "teenage engineering - YouTube";
          tags = [ "music", "electronics", "youtube" ];
          keyword = "teenageengineering";
          url = "https://www.youtube.com/results?search_query=teenage+engineering";

}
{
   name = "(35) How to use Interactive Brokers Trader Workstation - TWS Strategy Lab - Option Trading Tutorial - YouTube";
          tags = [ "trading", "tws", "options", "youtube" ];
          keyword = "twsstrategylab";
          url = "https://www.youtube.com/watch?v=PxyTFgu53-g&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=78";

}
{
   name = "(40) How to Use Probability Lab to Set Up an Options Trading Strategy in Interactive Brokers - YouTube";
          tags = [ "trading", "options", "interactivebrokers", "youtube" ];
          keyword = "probabilitylab";
          url = "https://www.youtube.com/watch?v=3uttbB55STw&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=77";

}
{
   name = "How to Properly Use Margin with Interactive Brokers - YouTube";
          tags = [ "trading", "interactivebrokers", "margin", "youtube" ];
          keyword = "ibkrmargin";
          url = "https://www.youtube.com/watch?v=Y-MmaJKQHAk&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=84&t=15s";

}
{
   name = "(40) Connected Series on the Balance Beam featuring Coach Amanda Borden - YouTube";
          tags = [ "gymnastics", "youtube", "coaching" ];
          keyword = "balancebeam";
          url = "https://www.youtube.com/watch?v=qVHvrveZl2E";

}
{
   name = "(40) Financial Hacking and Optimization - YouTube";
          tags = [ "finance", "optimization", "youtube" ];
          keyword = "financialhacking";
          url = "https://www.youtube.com/playlist?list=PLePBf4ZtCKhp_spxhte1V729O91_SEXx5";

}
{
   name = "(35) IBKR Platform Videos - YouTube";
          tags = [ "trading", "interactivebrokers", "youtube" ];
          keyword = "ibkrplatformvideos";
          url = "https://www.youtube.com/playlist?list=PLePBf4ZtCKhqxQDPcHJ3zEFxrEowXTmrp";

}
{
   name = "(40) Interactive Brokers TWS Platform: How to trade directly from the Charts! - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twscharttrading";
          url = "https://www.youtube.com/watch?v=SGSxig40mgY&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=99&t=390s";

}
{
   name = "(40) TWS Trading Tutorial | Order Types, Presets & Routing - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twstutorial";
          url = "https://www.youtube.com/watch?v=AMCNNNlK8D0&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=100&t=146s";

}
{
   name = "(40) Interactive Brokers Platform Tutorial for Day Trading 2023 (Level II, Hotkeys, Indicators etc) - YouTube";
          tags = [ "trading", "interactivebrokers", "youtube" ];
          keyword = "ibkrdaytradingtutorial";
          url = "https://www.youtube.com/watch?v=UWTWz2GZq30&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=105&t=866s";

}
{
   name = "(35) Trader Workstation MOST IMPORTANT SETTINGS - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twssettings";
          url = "https://www.youtube.com/watch?v=PeLgfvPFPv8&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=108";

}
{
   name = "(35) Become a Chart Patterns 'BEAST' | 3 Hours of 'Uninterrupted' Chart pattern course for beginners💯😎 - YouTube";
          tags = [ "trading", "chartpatterns", "youtube" ];
          keyword = "chartpatternsbeast";
          url = "https://www.youtube.com/watch?v=aVGrr2hMY5o&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=116&t=8s";

}
{
   name = "(34) Random video for you! #4 - YouTube";
          tags = [ "youtube", "random" ];
          keyword = "randomvideo";
          url = "https://www.youtube.com/watch?v=DlW8709Rc_0";

}
{
   name = "(34) YouTube";
          tags = [ "youtube", "history" ];
          keyword = "youtubehistory";
          url = "https://www.youtube.com/feed/history";

}
{
   name = "Interactive: Compare 250+ Impact Wrenches, 1000+ Tools - YouTube";
          tags = [ "tools", "comparison", "youtube" ];
          keyword = "impactwrenches";
          url = "https://www.youtube.com/watch?v=w7hKQ1SeNrk";

}
{
   name = "(35) Not Just Fake but Counterfeit Power Tools - YouTube";
          tags = [ "tools", "counterfeit", "youtube" ];
          keyword = "counterfeittools";
          url = "https://www.youtube.com/watch?v=3oBiFDr4bRU";

}
{
   name = "(35) Buying \"5000\" Lumen Flashlights | New Olight, AceBeam & More - YouTube";
          tags = [ "flashlights", "reviews", "youtube" ];
          keyword = "lumenflashlights";
          url = "https://www.youtube.com/watch?v=EBPQKeeYTfo";

}
{
   name = "(35) How Amazon Made the 1 Million Lumen Flashlight - YouTube";
          tags = [ "amazon", "flashlights", "youtube" ];
          keyword = "amazonflashlight";
          url = "https://www.youtube.com/watch?v=ceA5xL6ggEw";

}
{
   name = "(35) How to setup Interactive Brokers Market Data - Stock and Option Realtime Data - YouTube";
          tags = [ "trading", "interactivebrokers", "marketdata", "youtube" ];
          keyword = "ibkrmarketdata";
          url = "https://www.youtube.com/watch?v=pb9k4X5Jc-k";

}
{
   name = "(35) Which Market Data Subscription do I Need? (Futures, Stocks, Options) - YouTube";
          tags = [ "trading", "marketdata", "youtube" ];
          keyword = "marketdatasubscription";
          url = "https://www.youtube.com/watch?v=poBQVfdsxt8";

}
{
   name = "(35) Easiest Way To Set Up Market Data Subscriptions In Interactive Brokers - YouTube";
          tags = [ "trading", "interactivebrokers", "marketdata", "youtube" ];
          keyword = "ibkrmarketdatasubscriptions";
          url = "https://www.youtube.com/watch?v=hsNQLuOiLo8";

}
{
   name = "(35) Interactive Brokers TWS API + TradingView Charts Python Tutorial (Updated) - YouTube";
          tags = [ "trading", "twsapi", "tradingview", "python", "youtube" ];
          keyword = "ibkrtwsapipython";
          url = "https://www.youtube.com/watch?v=ZEtsLuXdC-g";

}
{
   name = "(35) Best IBKR TWS Scanner Settings for Day Trading - YouTube";
          tags = [ "trading", "tws", "scanner", "youtube" ];
          keyword = "ibkrtwsscanner";
          url = "https://www.youtube.com/watch?v=MevAc8brVOs";

}
{
   name = "(35) How to get LIVE Interactive Brokers Market Data Subscription (NO Delayed Market Data) - YouTube";
          tags = [ "trading", "interactivebrokers", "marketdata", "youtube" ];
          keyword = "ibkrlivemarketdata";
          url = "https://www.youtube.com/watch?v=r9SF_81fHrc";

}
{
   name = "TWS Setup for Day Trading Options & Stocks - Interactive Brokers - YouTube";
          tags = [ "trading", "tws", "options", "stocks", "youtube" ];
          keyword = "twsdaytradingsetup";
          url = "https://www.youtube.com/watch?v=C2E9yyi0l2s";

}
{
   name = "(35) I hated the TWS SCAN until I found these settings - Interactive Brokers - YouTube";
          tags = [ "trading", "tws", "scanner", "youtube" ];
          keyword = "twsscannerhacks";
          url = "https://www.youtube.com/watch?v=Y6NH7WydXyk";

}
{
   name = "(35) Best Day Trading Computer Setup - 2K VS 4K Trading Monitors? - YouTube";
          tags = [ "trading", "setup", "monitors", "youtube" ];
          keyword = "daytradingcomputers";
          url = "https://www.youtube.com/watch?v=jgRL3IRVaso";

}
{
   name = "(35) Best TWS Options Trading Layout for Interactive Brokers (Charts & Options Chain Platform Tutorial) - YouTube";
          tags = [ "trading", "tws", "options", "youtube" ];
          keyword = "twsoptionslayout";
          url = "https://www.youtube.com/watch?v=lcLFdmJtGEk";

}
{
   name = "(35) TradingView SECRET Settings That You Need to Know! - YouTube";
          tags = [ "tradingview", "settings", "youtube" ];
          keyword = "tradingviewsecrets";
          url = "https://www.youtube.com/watch?v=RhZQd4VM6JA";

}
{
   name = "(35) The 3 Most EPIC TradingView Settings You Need! - YouTube";
          tags = [ "tradingview", "settings", "youtube" ];
          keyword = "epictradingviewsettings";
          url = "https://www.youtube.com/watch?v=6XNiC8uohes";

}
{
   name = "(35) How to Convert Currency & Commissions Structure (Interactive Brokers) - YouTube";
          tags = [ "trading", "interactivebrokers", "currency", "commissions", "youtube" ];
          keyword = "ibkrcurrencycommissions";
          url = "https://www.youtube.com/watch?v=LHne1L68TJc";

}
{
   name = "(35) FULL Interactive Brokers TWS Tutorial For Beginners - (Chart, Level II, Hotkeys, Options, Settings) - YouTube";
          tags = [ "trading", "tws", "tutorial", "youtube" ];
          keyword = "fulltwstutorial";
          url = "https://www.youtube.com/watch?v=O_hWFar_aHE";

}
{
   name = "(35) Step-by-Step ULTIMATE TradingView Tutorial 2024 - YouTube";
          tags = [ "tradingview", "tutorial", "youtube" ];
          keyword = "ultimatetradingview";
          url = "https://www.youtube.com/watch?v=dqCSdF3KuPc";

}
{
   name = "Best TradingView Indicators 2024";
          tags = [ "tradingview", "indicators", "best" ];
          keyword = "besttradingviewindicators";
          url = "https://www.clickcapital.io/tradingview-indicators";

}
{
   name = "EMCS - Xtrackers MSCI Emerging Markets Climate Selection ETF Stock Price and Quote";
          tags = [ "finance", "etf", "stocks" ];
          keyword = "emcs";
          url = "https://finviz.com/quote.ashx?t=EMCS&p=d";

}
{
   name = "Meta Careers | Do the Most Meaningful Work of Your Career | Meta Careers";
          tags = [ "jobs", "meta", "careers" ];
          keyword = "metacareers";
          url = "https://www.metacareers.com/";

}
{
   name = "Add-ons Manager";
          tags = [ "firefox", "addons" ];
          keyword = "firefoxaddons";
          url = "about:addons";

}
{
   name = "Inbox (36) - laurentf84@gmail.com - Gmail";
          tags = [ "gmail", "email" ];
          keyword = "gmailinbox";
          url = "https://mail.google.com/mail/u/0/#inbox?messagePartId=0.3";

}
{
   name = "Google Calendar - Tuesday, March 19, 2024, today";
          tags = [ "google", "calendar" ];
          keyword = "googlecalendar";
          url = "https://calendar.google.com/calendar/u/0/r";

}
{
   name = "Home - Google Drive";
          tags = [ "google", "drive", "cloud" ];
          keyword = "googledrive";
          url = "https://drive.google.com/drive/home";

}
{
   name = "Gemini";
          tags = [ "ai", "google" ];
          keyword = "gemini";
          url = "https://gemini.google.com/app";

}
{
   name = "Job Search.xlsx - Google Sheets";
          tags = [ "jobsearch", "googlesheets", "tracking" ];
          keyword = "jobsearchsheet";
          url = "https://docs.google.com/spreadsheets/d/1Cu3vSEp2Aj35C5aNzm-E507mcjoLQCNp/edit#gid=539356267";

}
{
   name = "PM Resume - Google Docs";
          tags = [ "resume", "productmanager", "googledocs" ];
          keyword = "pmresume";
          url = "https://docs.google.com/document/d/1z3_sxmaKG0B_oqq45xPIyIyVpEgiQAMrat3A4-0x1MQ/edit#heading=h.y7d3xdxnr44m";

}
{
   name = "POp Resume - Google Docs";
          tags = [ "resume", "productoperations", "googledocs" ];
          keyword = "popresume";
          url = "https://docs.google.com/document/d/1YTdMzfByzbKisoab6dRnFQM5N_cVKjMUzioilytX_sw/edit";

}
{
   name = "Finance Resume - Google Docs";
          tags = [ "resume", "finance", "googledocs" ];
          keyword = "financeresume";
          url = "https://docs.google.com/document/d/1H8TuIoam9njMGu7nlmNTM9FZzUdV4TEJ1wnvW4jGPTw/edit";

}
{
   name = "Analyst Resume - Google Docs";
          tags = [ "resume", "analyst", "googledocs" ];
          keyword = "analystresume";
          url = "https://docs.google.com/document/d/1TVDbpe5DKxHbiaVwWL6Iwo483rVjgrwtk9OG25aUMc4/edit";

}
{
   name = "Israel Brokerage & Investment";
          tags = [ "finance", "trading", "israel" ];
          keyword = "israelbrokerage";
          url = "https://ibi.viewtrade.com/secure/account/portfolio.jsp";

}
{
   name = "BingX Cryptocurrency Exchange｜Bitcoin Ethereum Solana Spots and Derivatives Trading";
          tags = [ "crypto", "exchange", "trading" ];
          keyword = "bingx";
          url = "https://bingx.com/en-us/";

}
{
   name = "Reddit - Dive into anything";
          tags = [ "reddit", "trading" ];
          keyword = "realddaytradingwiki";
          url = "https://www.reddit.com/r/RealDayTrading/wiki/index/";

}
{
   name = "werx";
          tags = [ "login", "sso" ];
          keyword = "werx";
          url = "https://iam.werxpace.click/auth/realms/werxpace/protocol/openid-connect/auth?client_id=public-sso&redirect_uri=https%3A%2F%2Fweb.werxpace.click%2F&state=e84a6517-5a6a-45c6-8e39-1e03f16a4e20&response_mode=fragment&response_type=code&scope=openid&nonce=aade0f0c-3376-47da-86b2-670aa78e5e4b";

}
{
   name = "GNU Press Shop temporarily closed | FSF Shop";
          tags = [ "gnu", "fsf", "shop" ];
          keyword = "gnupress";
          url = "https://shop.fsf.org/";

}
{
   name = "OpenAI tokenizer";
          tags = [ "ai", "openai", "tokenizer" ];
          keyword = "openaistokenizer";
          url = "https://platform.openai.com/tokenizer";

}
{
   name = "Gemini";
          tags = [ "ai", "google" ];
          keyword = "gemini";
          url = "https://gemini.google.com/app/250fbd46aa83c4cc";

}
{
   name = "Perplexity";
          tags = [ "ai", "search" ];
          keyword = "perplexity";
          url = "https://www.perplexity.ai/";

}
{
   name = "Chat Playground - OpenAI API";
          tags = [ "ai", "openai", "chat" ];
          keyword = "chatplayground";
          url = "https://platform.openai.com/playground/chat?models=gpt-4o";

}
{
   name = "(12) Hirak Berlin حراك برلين🇩🇿🇩🇪 (@BerlinHirak) / X";
          tags = [ "socialmedia", "politics" ];
          keyword = "hirakberlin";
          url = "https://x.com/BerlinHirak";

}
{
   name = "(16) Oren Barsky 🎗️ on X: \"For most Arabs who experienced the Nakba, it was also the first time they discovered they were Palestinians. Until then, they were primarily Arabs, migrant workers who had arrived only a decade or two earlier to make a living, and suddenly found themselves as Palestinian\" / X";
          tags = [ "history", "palestine", "socialmedia" ];
          keyword = "orenbarsky";
          url = "https://x.com/orenbarsky/status/1791579971812479209";

}
{
   name = "Facebook";
          tags = [ "socialmedia" ];
          keyword = "facebook";
          url = "https://www.facebook.com/ilja.sichrovsky";

}
{
   name = "YoutubeBuddy · Streamlit";
          tags = [ "youtube", "tool", "ai" ];
          keyword = "youtubebuddy";
          url = "https://youtubebuddy.streamlit.app/";

}
{
   name = "Complete List of Prompts & Styles for Suno AI Music (2024) | by Travis Nicholson | Medium";
          tags = [ "ai", "music", "prompts" ];
          keyword = "sunoaimusic";
          url = "https://travisnicholson.medium.com/complete-list-of-prompts-styles-for-suno-ai-music-2024-33ecee85f180";

}
{
   name = "Untitled prompt | Google AI Studio";
          tags = [ "ai", "google" ];
          keyword = "googleaistudio";
          url = "https://aistudio.google.com/prompts/new_chat";

}
{
   name = "IBI Trade (US)";
          tags = [ "finance", "trading" ];
          keyword = "ibitradeus";
          url = "https://ibi.viewtrade.com/";

}
{
   name = "IBI Spark (IL)";
          tags = [ "finance", "trading" ];
          keyword = "ibisparkil";
          url = "https://sparkibi.ordernet.co.il/#/auth";

}
{
   name = "Tradovate - Platform Knowledge Videos";
          tags = [ "finance", "trading", "education" ];
          keyword = "tradovatevideos";
          url = "https://www.tradovate.com/videos/?utm_term=demo&utm_campaign=Demo%20to%20Customer%202019&utm_medium=Email&_hsmi=103430268&utm_content=Demo%20to%20Customer%20%233%20%E2%80%94%20Features&utm_source=email";

}
{
   name = "NextGen IBI";
          tags = [ "finance", "trading" ];
          keyword = "nextgenibi";
          url = "https://ibi.orbisfn.io/login";

}
{
   name = "Tiger Brokers _ Hong Kong / U.S. Stock Market Quotes";
          tags = [ "finance", "trading", "stocks" ];
          keyword = "tigerbrokers";
          url = "https://www.itiger.com/sg";

}
{
   name = "Interactive Brokers";
          tags = [ "finance", "trading" ];
          keyword = "interactivebrokers";
          url = "https://www.interactivebrokers.com/";

}
{
   name = "Swing Alerts | ClickCapital";
          tags = [ "finance", "trading", "alerts" ];
          keyword = "swingalerts";
          url = "https://www.clickcapital.io/alerts-open-trades";

}
{
   name = "Stock Picks | ClickCapital";
          tags = [ "finance", "trading", "stocks" ];
          keyword = "stockpicks";
          url = "https://www.clickcapital.io/stock-picks-members";

}
{
   name = "Yahoo Finance - Stock Market Live, Quotes, Business & Finance News";
          tags = [ "finance", "news", "stocks" ];
          keyword = "yahoofinance";
          url = "https://finance.yahoo.com/";

}
{
   name = "ETF Screener | etf.com";
          tags = [ "finance", "etf", "screener" ];
          keyword = "etfscreener";
          url = "https://www.etf.com/etfanalytics/etf-screener";

}
{
   name = "ETF Tools - stockanalysis.com";
          tags = [ "finance", "etf", "tools" ];
          keyword = "etftools";
          url = "https://stockanalysis.com/etf/screener/";

}
{
   name = "ETF Research Center";
          tags = [ "finance", "etf", "research" ];
          keyword = "etfresearch";
          url = "https://www.etfrc.com/index.php";

}
{
   name = "ETF Database: The Original & Comprehensive Guide to ETFs";
          tags = [ "finance", "etf", "database" ];
          keyword = "etfdatabase";
          url = "https://etfdb.com/";

}
{
   name = "SweepCast | Unusual Options Activity for Retail Traders - Follow Smart Money";
          tags = [ "finance", "options", "trading" ];
          keyword = "sweepcast";
          url = "https://www.sweepcast.com/";

}
{
   name = "Pine Script™ v5 User Manual";
          tags = [ "pinescript", "tradingview", "documentation" ];
          keyword = "pinescriptmanual";
          url = "https://www.tradingview.com/pine-script-docs/en/v5/Introduction.html";

}
{
   name = "Free Options Trading Courses | Option Alpha";
          tags = [ "options", "trading", "education" ];
          keyword = "optionalpha";
          url = "https://optionalpha.com/courses";

}
{
   name = "Learn to Trade & Invest: Insights, Resources";
          tags = [ "trading", "investing", "education" ];
          keyword = "tastytradelearn";
          url = "https://tastytrade.com/learn/";

}
{
   name = "Introduction to Options - CME Group";
          tags = [ "options", "cme", "education" ];
          keyword = "cmeoptionsintro";
          url = "https://www.cmegroup.com/education/courses/introduction-to-options.html";

}
{
   name = "Option Strategies - CME Group";
          tags = [ "options", "cme", "strategies" ];
          keyword = "cmeoptionstrategies";
          url = "https://www.cmegroup.com/education/courses/option-strategies.html";

}
{
   name = "Tools for Option Analysis - CME Group";
          tags = [ "options", "cme", "analysis" ];
          keyword = "cmeoptiontools";
          url = "https://www.cmegroup.com/education/courses/tools-for-option-analysis.html";

}
{
   name = "Bloomberg for Education";
          tags = [ "finance", "education", "bloomberg" ];
          keyword = "bloombergeducation";
          url = "https://portal.bloombergforeducation.com/";

}
{
   name = "The Basics of Treasuries Basis - CME Group";
          tags = [ "finance", "fixedincome", "cme" ];
          keyword = "cmetreasuries";
          url = "https://www.cmegroup.com/education/courses/introduction-to-treasuries/the-basics-of-treasuries-basis.html";

}
{
   name = "Technical Analysis - CME Group";
          tags = [ "finance", "analysis", "cme" ];
          keyword = "cmetechanalysis";
          url = "https://www.cmegroup.com/education/courses/technical-analysis.html";

}
{
   name = "Trading and Analysis - CME Group";
          tags = [ "finance", "trading", "analysis", "cme" ];
          keyword = "cmetradinganalysis";
          url = "https://www.cmegroup.com/education/courses/trading-and-analysis.html";

}
{
   name = "Learn about Key Economic Events - CME Group";
          tags = [ "finance", "economics", "cme" ];
          keyword = "cmeeconomicevents";
          url = "https://www.cmegroup.com/education/courses/learn-about-key-economic-events.html";

}
{
   name = "Trade and Risk Management - CME Group";
          tags = [ "finance", "riskmanagement", "cme" ];
          keyword = "cmeriskmanagement";
          url = "https://www.cmegroup.com/education/courses/trade-and-risk-management.html";

}
{
   name = "Introduction to Equity Index Products - CME Group";
          tags = [ "finance", "equity", "cme" ];
          keyword = "cmeequityintro";
          url = "https://www.cmegroup.com/education/courses/introduction-to-equity-index-products.html";

}
{
   name = "Futures vs. ETFs - CME Group";
          tags = [ "finance", "futures", "etf", "cme" ];
          keyword = "cmefuturesvsetf";
          url = "https://www.cmegroup.com/education/courses/futures-vs-etfs.html";

}
{
   name = "Reddit - Dive into anything";
          tags = [ "reddit", "trading" ];
          keyword = "realddaytradingwiki";
          url = "https://www.reddit.com/r/RealDayTrading/wiki/index/";

}
{
   name = "(5) Adding a Sector List and the Top 10 for each sector to a Trading View watchlist : RealDayTrading";
          tags = [ "trading", "watchlist", "sectors" ];
          keyword = "tradingviewsectors";
          url = "https://www.reddit.com/r/RealDayTrading/comments/18ap05y/adding_a_sector_list_and_the_top_10_for_each/";

}
{
   name = "Sign in to TC2000®";
          tags = [ "trading", "platform" ];
          keyword = "tc2000signin";
          url = "https://www.tc2000.com/sign-in?webplatform=true&returnURL=https://webplatform.tc2000.com/RASHTML5Gateway/";

}
{
   name = "(5) Sector scanner for Trading View : RealDayTrading";
          tags = [ "trading", "scanner", "sectors" ];
          keyword = "tradingviewsectorscanner";
          url = "https://www.reddit.com/r/RealDayTrading/comments/x8v8cd/sector_scanner_for_trading_view/";

}
{
   name = "> Sector Relative Strength — Indicator by atlas54000 — TradingView";
          tags = [ "tradingview", "indicator", "relativestrength" ];
          keyword = "sectorrelativestrength";
          url = "https://www.tradingview.com/script/fcSCAIv5-Sector-Relative-Strength/";

}
{
   name = "(5) I \"Shorted Stupid\" and I Got Burned! : RealDayTrading";
          tags = [ "trading", "lessons" ];
          keyword = "shortedstupid";
          url = "https://www.reddit.com/r/RealDayTrading/comments/y24905/i_shorted_stupid_and_i_got_burned/";

}
{
   name = "> (5) Bearish Trend Days. How To Spot Them and How To Trade Them : RealDayTrading";
          tags = [ "trading", "bearish", "strategy" ];
          keyword = "bearishtrenddays";
          url = "https://www.reddit.com/r/RealDayTrading/comments/xy8756/bearish_trend_days_how_to_spot_them_and_how_to/";

}
{
   name = ">> (10) Bearish Trend Days - How To Trade Them - YouTube";
          tags = [ "trading", "youtube", "bearish" ];
          keyword = "bearishtrenddaysyoutube";
          url = "https://www.youtube.com/watch?v=kPfWxS12yUY";

}
{
   name = "> (10) Why This Gap and Go Pattern Failed - YouTube";
          tags = [ "trading", "youtube", "patterns" ];
          keyword = "gapandgofailed";
          url = "https://www.youtube.com/watch?v=FmhUYeGCGgU";

}
{
   name = "(4) Simple RS Strategy using trendline (Great for newbies) : RealDayTrading";
          tags = [ "trading", "strategy", "beginners" ];
          keyword = "simplersstrategy";
          url = "https://www.reddit.com/r/RealDayTrading/comments/ty0tjw/simple_rs_strategy_using_trendline_great_for/";

}
{
   name = "(5) A Tool For Compiling Your Market Rebound Picks : RealDayTrading";
          tags = [ "trading", "tools", "marketrebound" ];
          keyword = "marketreboundpicks";
          url = "https://www.reddit.com/r/RealDayTrading/comments/v5kjav/a_tool_for_compiling_your_market_rebound_picks/";

}
{
   name = "(5) Analyzed 450 Trades - This might be helpful : RealDayTrading";
          tags = [ "trading", "analysis" ];
          keyword = "analyzedtrades";
          url = "https://www.reddit.com/r/RealDayTrading/comments/t7li41/analyzed_450_trades_this_might_be_helpful/";

}
{
   name = "(5) Need help with identifying institutional support. : RealDayTrading";
          tags = [ "trading", "support", "institutional" ];
          keyword = "institutionalsupport";
          url = "https://www.reddit.com/r/RealDayTrading/comments/16zzjun/need_help_with_identifying_institutional_support/";

}
{
   name = "(5) Update to relative strength stock and sector script post : RealDayTrading";
          tags = [ "trading", "relativestrength", "script" ];
          keyword = "relativestrengthupdate";
          url = "https://www.reddit.com/r/RealDayTrading/comments/weuik4/update_to_relative_strength_stock_and_sector_script_post/";

}
{
   name = "(5) Real Relative Strength to SECTOR Indicator + Auto Sector Selection [TOS/TV] : RealDayTrading";
          tags = [ "trading", "relativestrength", "indicator" ];
          keyword = "realsectorrs";
          url = "https://www.reddit.com/r/RealDayTrading/comments/x9dwv0/real_relative_strength_to_sector_indicator_auto/";

}
{
   name = "(5) Strong sector or strong stock? : RealDayTrading";
          tags = [ "trading", "sectors", "stocks" ];
          keyword = "strongsectorstock";
          url = "https://www.reddit.com/r/RealDayTrading/comments/10n9i59/strong_sector_or_strong_stock/";

}
{
   name = "(5) Sector / Industry Strength Comparison on Tradingview : RealDayTrading";
          tags = [ "tradingview", "sectors", "industry" ];
          keyword = "sectorindustrystrength";
          url = "https://www.reddit.com/r/RealDayTrading/comments/tiprot/sector_industry_strength_comparison_on_tradingview/";

}
{
   name = "(5) (Expanded to *Most* Stocks) Real Relative Strength to SECTOR Indicator + Auto Sector Selection [TOS] : RealDayTrading";
          tags = [ "trading", "relativestrength", "indicator" ];
          keyword = "expandedrealsectorrs";
          url = "https://www.reddit.com/r/RealDayTrading/comments/z02d6b/expanded_to_most_stocks_real_relative_strength_to/";

}
{
   name = "(5) Stacked Stock/Sector/Market RS/RW Arrows for TradingView : RealDayTrading";
          tags = [ "tradingview", "indicators", "rsrw" ];
          keyword = "stackedrsrw";
          url = "https://www.reddit.com/r/RealDayTrading/comments/z9u03i/stacked_stocksectormarket_rsrw_arrows_for/";

}
{
   name = "(5) Question About Sector Performance : RealDayTrading";
          tags = [ "trading", "sectors", "performance" ];
          keyword = "sectorperformancequestion";
          url = "https://www.reddit.com/r/RealDayTrading/comments/170uagf/question_about_sector_performance/";

}
{
   name = "(5) Relative Strength to stock and sector indicator for TOS : RealDayTrading";
          tags = [ "trading", "relativestrength", "indicator" ];
          keyword = "tosrelativestrength";
          url = "https://www.reddit.com/r/RealDayTrading/comments/wb3x7c/relative_strength_to_stock_and_sector_indicator/";

}
{
   name = "(5) Sector / Industry Strength Comparison on Tradingview : RealDayTrading";
          tags = [ "tradingview", "sectors", "industry" ];
          keyword = "sectorindustrystrength";
          url = "https://www.reddit.com/r/RealDayTrading/comments/tiprot/sector_industry_strength_comparison_on_tradingview/";

}
{
   name = "(5) I \"Shorted Stupid\" and I Got Burned! : RealDayTrading";
          tags = [ "trading", "lessons" ];
          keyword = "shortedstupid";
          url = "https://www.reddit.com/r/RealDayTrading/comments/y24905/i_shorted_stupid_and_i_got_burned/";

}
{
   name = "(5) A very handy way to pull financial data : RealDayTrading";
          tags = [ "finance", "data", "tools" ];
          keyword = "financialdatapull";
          url = "https://www.reddit.com/r/RealDayTrading/comments/11widn4/a_very_handy_way_to_pull_financial_data/";

}
{
   name = "> Download | OpenBB Terminal";
          tags = [ "finance", "tools", "openbb" ];
          keyword = "openbbdownload";
          url = "https://my.openbb.co/app/terminal/download";

}
{
   name = "Real Relative Strength to SECTOR Indicator + Auto Sector Selection [TOS/TV] : RealDayTrading";
          tags = [ "trading", "relativestrength", "indicator" ];
          keyword = "realsectorrs";
          url = "https://www.reddit.com/r/RealDayTrading/comments/x9dwv0/real_relative_strength_to_sector_indicator_auto/";

}
{
   name = "OpenBB Terminal Docs";
          tags = [ "finance", "tools", "documentation" ];
          keyword = "openbbdocs";
          url = "https://docs.openbb.co/terminal";

}
{
   name = "Order Types and Algos | Interactive Brokers LLC";
          tags = [ "trading", "interactivebrokers", "ordertypes" ];
          keyword = "ibkrordertypes";
          url = "https://www.interactivebrokers.com/en/trading/ordertypes.php";

}
{
   name = "Basic Economics | Trading Course | Traders' Academy | IBKR Campus";
          tags = [ "economics", "trading", "education" ];
          keyword = "ibkreconomics";
          url = "https://ibkrcampus.com/trading-course/introduction-to-microeconomics/?src=_X_MAILING_ID&eid=_X_EID&blst=NL-TI_cps_artclbtn";

}
{
   name = "Getting Started with TWS | Trading Lesson | Traders' Academy | IBKR Campus";
          tags = [ "trading", "tws", "education" ];
          keyword = "ibkrtwsgettingstarted";
          url = "https://ibkrcampus.com/trading-lessons/getting-started-with-tws/";

}
{
   name = "בית פרטי/ קוטג', פרדס חנה כרכור | אלפי מודעות חדשות בכל יום!";
          tags = [ "realestate", "israel" ];
          keyword = "yad2pardeshanna";
          url = "https://www.yad2.co.il/realestate/item/qi61ryus?ad-location=Main+feed+listings&opened-from=Feed+view&component-type=main_feed&index=19&color-type=Grey";

}
{
   name = "(1) Veena Krishnamurthy | LinkedIn";
          tags = [ "linkedin", "profile" ];
          keyword = "veenakrishnamurthy";
          url = "https://www.linkedin.com/in/veena-krishnamurthy/";

}
{
   name = "GitHub - wilsonfreitas/awesome-quant: A curated list of insanely awesome libraries, packages and resources for Quants (Quantitative Finance)";
          tags = [ "github", "finance", "quant" ];
          keyword = "awesomequant";
          url = "https://github.com/wilsonfreitas/awesome-quant";

}
{
   name = "OCC - Investor Education";
          tags = [ "finance", "education", "options" ];
          keyword = "occ";
          url = "https://www.theocc.com/company-information/investor-education";

}
{
   name = "koyfin";
          tags = [ "finance", "platform" ];
          keyword = "koyfin";
          url = "https://app.koyfin.com/home";

}
{
   name = "Select Sector SPDR ETFs - Sector Spiders ETFs | SPDR S&P Stock";
          tags = [ "finance", "etf", "sectors" ];
          keyword = "sectorspdrs";
          url = "https://www.sectorspdrs.com/";

}
{
   name = "Investopedia Stock Simulator";
          tags = [ "finance", "simulator", "investing" ];
          keyword = "investopediasimulator";
          url = "https://www.investopedia.com/simulator/portfolio";

}
{
   name = "מדריכים וכלים של פעמונים - paamonim";
          tags = [ "finance", "tools", "israel" ];
          keyword = "paamonimtools";
          url = "https://www.paamonim.org/he/%D7%9B%D7%9C%D7%99%D7%9D-%D7%95%D7%9E%D7%97%D7%A9%D7%91%D7%95%D7%A0%D7%99%D7%9D/";

}
{
   name = "TipRanks";
          tags = [ "finance", "research" ];
          keyword = "tipranks";
          url = "https://www.tipranks.com/dashboard";

}
{
   name = "(18) TWS Trading Tutorial | Order Types, Presets & Routing - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twstutorial";
          url = "https://www.youtube.com/watch?v=AMCNNNlK8D0&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=102&t=62s";

}
{
   name = "> (18) How to use Adjustable Stop and Scale Target Orders in TWS - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twsadjustableorders";
          url = "https://www.youtube.com/watch?v=RYykmLiGbMU&t=493s";

}
{
   name = "> (18) How to use a Bracket Order in TWS (Stop-loss/Take Profit) - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twsbracketorder";
          url = "https://www.youtube.com/watch?v=b-x_cwH99C4&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=63";

}
{
   name = "> (18) How to Properly Use Margin with Interactive Brokers - YouTube";
          tags = [ "trading", "interactivebrokers", "margin", "youtube" ];
          keyword = "ibkrmargin";
          url = "https://www.youtube.com/watch?v=Y-MmaJKQHAk&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=85";

}
{
   name = "> (18) Interactive Brokers TWS Platform: How to trade directly from the Charts! - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twscharttrading";
          url = "https://www.youtube.com/watch?v=SGSxig40mgY&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=101&t=390s";

}
{
   name = "> (18) How to FIX Your IBKR TWS Charts in 2 Minutes - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twsfixcharts";
          url = "https://www.youtube.com/watch?v=hrO3KoXs5MU&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=100";

}
{
   name = ">> (18) Step-by-Step TWS CHART Settings - (Interactive Brokers Tutorial) - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twschartsettings";
          url = "https://www.youtube.com/watch?v=F1d8r-MWjfM&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=111";

}
{
   name = "> (18) 10 Tips & Tricks To Master Interactive Brokers - YouTube";
          tags = [ "trading", "interactivebrokers", "youtube" ];
          keyword = "ibkrtips";
          url = "https://www.youtube.com/watch?v=HR0S-0sgb7o&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=108";

}
{
   name = ">> (18) Interactive Brokers Platform Tutorial for Day Trading 2023 (Level II, Hotkeys, Indicators etc) - YouTube";
          tags = [ "trading", "interactivebrokers", "youtube" ];
          keyword = "ibkrdaytradingtutorial";
          url = "https://www.youtube.com/watch?v=UWTWz2GZq30&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=106&t=866s";

}
{
   name = ">> (18) How to Set Up TWS layout/Interactive Brokers - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twssetup";
          url = "https://www.youtube.com/watch?v=mYVnhTe2ce0&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=74";

}
{
   name = ">> (18) Fastest Way to Trade on Interactive Brokers | Day Trading Buttons - YouTube";
          tags = [ "trading", "interactivebrokers", "youtube" ];
          keyword = "ibkrfasttrading";
          url = "https://www.youtube.com/watch?v=Mb0avUe0HxM&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=110";

}
{
   name = "Fear and Greed Index - Investor Sentiment | CNN";
          tags = [ "finance", "sentiment", "cnn" ];
          keyword = "feargreedindex";
          url = "https://edition.cnn.com/markets/fear-and-greed";

}
{
   name = "Set Up DNS For A Basic Website | Dyn Help Center";
          tags = [ "web", "dns", "hosting" ];
          keyword = "setupdns";
          url = "https://help.dyn.com/setting-up-dns-for-your-new-website/";

}
{
   name = "Visual Directory";
          tags = [ "software", "directory" ];
          keyword = "visualdirectory";
          url = "https://similarweb.officespacesoftware.com/visual-directory/floors/8/seats/973";

}
{
   name = "Google Analytics Solutions Gallery";
          tags = [ "googleanalytics", "analytics", "tools" ];
          keyword = "gasolutionsgallery";
          url = "https://analytics.google.com/analytics/gallery/?hl=en_US#posts/search/%3F_.type%3DDASHBOARD%26_.start%3D0/";

}
{
   name = "Verify view filters - Analytics Help";
          tags = [ "googleanalytics", "filters", "help" ];
          keyword = "gafilters";
          url = "https://support.google.com/analytics/answer/6046990?hl=en#zippy=%2Cin-this-article";

}
{
   name = "About regular expressions (regex) - Analytics Help";
          tags = [ "googleanalytics", "regex", "help" ];
          keyword = "garegex";
          url = "https://support.google.com/analytics/answer/1034324?hl=en";

}
{
   name = "Mini guides - Analytics Help";
          tags = [ "googleanalytics", "guides", "help" ];
          keyword = "gaminiguides";
          url = "https://support.google.com/analytics/topic/9328240";

}
{
   name = "Set up the Analytics global site tag - Analytics Help";
          tags = [ "googleanalytics", "tags", "help" ];
          keyword = "gaglobalsitetag";
          url = "https://support.google.com/analytics/answer/1008080#zippy=%2Cin-this-article";

}
{
   name = "Tag Assistant Legacy (by Google) - Chrome Web Store";
          tags = [ "googleanalytics", "chromeextension", "tools" ];
          keyword = "tagassistant";
          url = "https://chrome.google.com/webstore/detail/tag-assistant-legacy-by-g/kejbdjndbnbjgmefkgdddjlbokphdefk";

}
{
   name = "View the history of account changes (Universal Analytics properties) - Analytics Help";
          tags = [ "googleanalytics", "history", "help" ];
          keyword = "gaaccounthistory";
          url = "https://support.google.com/analytics/answer/2949085";

}
{
   name = "Diagnostics messages - Analytics Help";
          tags = [ "googleanalytics", "diagnostics", "help" ];
          keyword = "gadiagnostics";
          url = "https://support.google.com/analytics/answer/6006306#zippy=%2Cin-this-article";

}
{
   name = "Common issues - Analytics Help";
          tags = [ "googleanalytics", "issues", "help" ];
          keyword = "gacommonissues";
          url = "https://support.google.com/analytics/topic/1009691";

}
{
   name = "Google Analytics user permissions - Analytics Help";
          tags = [ "googleanalytics", "permissions", "help" ];
          keyword = "gaperissions";
          url = "https://support.google.com/analytics/answer/2884495";

}
{
   name = "Customer journey mapping: the path to loyal customers - Think with Google";
          tags = [ "marketing", "customerjourney", "google" ];
          keyword = "customerjourneymapping";
          url = "https://www.thinkwithgoogle.com/consumer-insights/consumer-journey/customer-journey-mapping/";

}
{
   name = "Adopting actionable data-driven marketing strategies - Think with Google";
          tags = [ "marketing", "datadriven", "google" ];
          keyword = "datadrivenmarketing";
          url = "https://www.thinkwithgoogle.com/marketing-strategies/data-and-measurement/data-driven-marketing-strategy/";

}
{
   name = "Advanced Google Analytics";
          tags = [ "googleanalytics", "course", "advanced" ];
          keyword = "gaadvancedcourse";
          url = "https://analytics.google.com/analytics/academy/course/7?authuser=1";

}
{
   name = "Google Tag Manager Fundamentals";
          tags = [ "googletagmanager", "course", "fundamentals" ];
          keyword = "gtmfundamentals";
          url = "https://analytics.google.com/analytics/academy/course/5?authuser=1";

}
{
   name = "Remarketing audiences you create - Analytics Help";
          tags = [ "googleanalytics", "remarketing", "help" ];
          keyword = "garemarketing";
          url = "https://support.google.com/analytics/answer/2611820?visit_id=637570295387160175-2120134827&rd=1#zippy=%2Cin-this-article";

}
{
   name = "Google Analytics Community";
          tags = [ "googleanalytics", "community", "help" ];
          keyword = "gacommunity";
          url = "https://support.google.com/analytics/community?hl=en&ctx=lithium";

}
{
   name = "Overview of Audience reports - Analytics Help";
          tags = [ "googleanalytics", "reports", "audience" ];
          keyword = "gaaudiencereports";
          url = "https://support.google.com/analytics/answer/1012034?hl=en#zippy=%2Cin-this-article";

}
{
   name = "Traffic source dimensions - Analytics Help";
          tags = [ "googleanalytics", "traffic", "dimensions" ];
          keyword = "gatrafficdimensions";
          url = "https://support.google.com/analytics/answer/1033173?hl=en";

}
{
   name = "Analyze channel contribution with Multi-Channel Funnels - Analytics Help";
          tags = [ "googleanalytics", "multichannel", "funnels" ];
          keyword = "gamultichannelfunnels";
          url = "https://support.google.com/analytics/answer/1191204?hl=en";

}
{
   name = "Exit Rate vs. Bounce Rate - Analytics Help";
          tags = [ "googleanalytics", "metrics", "bouncerate" ];
          keyword = "gaexitbounce";
          url = "https://support.google.com/analytics/answer/2525491?hl=en";

}
{
   name = "Best Practices for collecting campaign data with custom URLs - Analytics Help";
          tags = [ "googleanalytics", "campaigns", "urls" ];
          keyword = "gacampaignurls";
          url = "https://support.google.com/analytics/answer/1037445?hl=en";

}
{
   name = "Navigating full reports: Part 1 - Analytics Help";
          tags = [ "googleanalytics", "reports", "navigation" ];
          keyword = "ganavigatingreports";
          url = "https://support.google.com/analytics/answer/6383012?hl=en";

}
{
   name = "Google Tag Manager vs Google Analytics: Fully Explained (2020)";
          tags = [ "googletagmanager", "googleanalytics", "comparison" ];
          keyword = "gtmvga";
          url = "https://www.analyticsmania.com/post/google-tag-manager-vs-google-analytics/";

}
{
   name = "[GA4] Implementation guide for Google Tag Manager - Analytics Help";
          tags = [ "googleanalytics", "ga4", "googletagmanager" ];
          keyword = "ga4gtm";
          url = "https://support.google.com/analytics/answer/10270783?hl=en&ref_topic=10270831#zippy=%2Cin-this-article";

}
{
   name = "linux - What do ALSA devices like \"hw:0,0\" mean? How do I figure out which to use? - Super User";
          tags = [ "linux", "audio", "alsa" ];
          keyword = "alsadevices";
          url = "https://superuser.com/questions/53957/what-do-alsa-devices-like-hw0-0-mean-how-do-i-figure-out-which-to-use";

}
{
   name = "Bit Perfect Audio from Linux | Headphone Reviews and Discussion - Head-Fi.org";
          tags = [ "linux", "audio", "headphones" ];
          keyword = "bitperfectaudio";
          url = "https://www.head-fi.org/threads/bit-perfect-audio-from-linux.561961/#post-7596268";

}
{
   name = "Linux man pages online";
          tags = [ "linux", "documentation", "manpages" ];
          keyword = "linuxmanpages";
          url = "https://man7.org/linux/man-pages/index.html";

}
{
   name = "about - awesome window manager";
          tags = [ "linux", "windowmanager", "awesome" ];
          keyword = "awesomewm";
          url = "https://awesomewm.org/";

}
{
   name = "[How To] Make Linux sound GREAT! - Contributions / Tutorials - Manjaro Linux Forum";
          tags = [ "linux", "audio", "manjaro" ];
          keyword = "linuxsoundgreat";
          url = "https://forum.manjaro.org/t/how-to-make-linux-sound-great/146143";

}
{
   name = "Buffers in Vim [Complete Beginner's Guide]";
          tags = [ "vim", "linux", "buffers" ];
          keyword = "vimbuffers";
          url = "https://linuxhandbook.com/vim-buffers/";

}
{
   name = "xon.sh documentation - python bash shell";
          tags = [ "linux", "shell", "python" ];
          keyword = "xonshdocs";
          url = "https://xon.sh/contents.html#installation";

}
{
   name = "fzf/ADVANCED.md at master · junegunn/fzf";
          tags = [ "linux", "fzf", "tools" ];
          keyword = "fzfadvanced";
          url = "https://github.com/junegunn/fzf/blob/master/ADVANCED.md#using-fzf-as-interactive-ripgrep-launcher";

}
{
   name = "Using Layouts for Personal Automation";
          tags = [ "linux", "automation", "layouts" ];
          keyword = "zellijlayouts";
          url = "https://zellij.dev/tutorials/layouts/";

}
{
   name = "Advanced Bash-Scripting Guide";
          tags = [ "linux", "bash", "scripting" ];
          keyword = "advancedbash";
          url = "https://tldp.org/LDP/abs/html/index.html";

}
{
   name = "Format Specifiers In C | A Complete Guide (+Code Examples) // Unstop";
          tags = [ "cprogramming", "formatspecifiers", "guide" ];
          keyword = "cformatspecifiers";
          url = "https://unstop.com/blog/format-specifiers-in-c";

}
{
   name = "xonsh 0.19.0 documentation";
          tags = [ "linux", "shell", "python" ];
          keyword = "xonshdocs";
          url = "https://xon.sh/contents.html";

}
{
   name = "https://github.com/anki-code/xonsh-cheatsheet/#xonsh-basics";
          tags = [ "linux", "shell", "cheatsheet" ];
          keyword = "xonshcheatsheet";
          url = "https://github.com/anki-code/xonsh-cheatsheet/#xonsh-basics";

}
{
   name = "GitHub - jlevy/the-art-of-command-line: Master the command line, in one page";
          tags = [ "linux", "commandline", "guide" ];
          keyword = "artofcommandline";
          url = "https://github.com/jlevy/the-art-of-command-line?tab=readme-ov-file#one-liners";

}
{
   name = "GitHub - gpakosz/.tmux: Oh my tmux! My self-contained, pretty & versatile tmux configuration made with 💛🩷💙🖤❤️🤍";
          tags = [ "linux", "tmux", "configuration" ];
          keyword = "ohmytmux";
          url = "https://github.com/gpakosz/.tmux?tab=readme-ov-file#configuration";

}
{
   name = "Tutorial - xonsh 0.19.0 documentation";
          tags = [ "linux", "shell", "tutorial" ];
          keyword = "xonsh_tutorial";
          url = "https://xon.sh/tutorial.html";

}
{
   name = "ideavim/doc/IdeaVim Plugins.md at master · JetBrains/ideavim · GitHub";
          tags = [ "vim", "ide", "plugins" ];
          keyword = "ideavimplugins";
          url = "https://github.com/JetBrains/ideavim/blob/master/doc/IdeaVim%20Plugins.md";

}
{
   name = "nvimawesome";
          tags = [ "neovim", "plugins", "awesome" ];
          keyword = "nvimawesome";
          url = "https://nvim-awesome.vercel.app/";

}
{
   name = "Modules labeled 'neovim' - LuaRocks";
          tags = [ "neovim", "lua", "modules" ];
          keyword = "luarocksneovim";
          url = "https://luarocks.org/labels/neovim";

}
{
   name = "top colorschemes | vimcolorschemes";
          tags = [ "vim", "colorschemes", "themes" ];
          keyword = "vimcolorschemes";
          url = "https://vimcolorschemes.com/i/top";

}
{
   name = "Philomatics Git Cheatsheet";
          tags = [ "git", "cheatsheet", "development" ];
          keyword = "gitcheatsheet";
          url = "https://philomatics.com/git-cheatsheet-release/";

}
{
   name = "Git Cheat Sheet – 50 Git Commands You Should Know";
          tags = [ "git", "cheatsheet", "commands" ];
          keyword = "gitcommands";
          url = "https://www.freecodecamp.org/news/git-cheat-sheet/";

}
{
   name = "Show and Tell Category? Ghostty and Fzf love! · ghostty-org/ghostty · Discussion #3527";
          tags = [ "terminal", "ghostty", "fzf" ];
          keyword = "ghosttyfzf";
          url = "https://github.com/ghostty-org/ghostty/discussions/3527";

}
{
   name = "pkazmier/ghostty-config: My Ghostty configuration";
          tags = [ "terminal", "ghostty", "configuration" ];
          keyword = "ghosttyconfig";
          url = "https://github.com/pkazmier/ghostty-config";

}
{
   name = "linkarzu/dotfiles-latest: My most up to date dotfiles";
          tags = [ "dotfiles", "configuration", "linux" ];
          keyword = "dotfileslatest";
          url = "https://github.com/linkarzu/dotfiles-latest/tree/main";

}
{
   name = "pkazmier/snacks.nvim: 🍿 A collection of QoL plugins for Neovim";
          tags = [ "neovim", "plugins", "lua" ];
          keyword = "snacksnvim";
          url = "https://github.com/pkazmier/snacks.nvim?tab=readme-ov-file";

}
{
   name = "pkazmier/nvim: My personal neovim configuration";
          tags = [ "neovim", "configuration", "lua" ];
          keyword = "pkazmiernvim";
          url = "https://github.com/pkazmier/nvim/tree/main";

}
{
   name = "pkazmier/wezterm-config: My personal wezterm configuration";
          tags = [ "terminal", "wezterm", "configuration" ];
          keyword = "weztermconfig";
          url = "https://github.com/pkazmier/wezterm-config";

}
{
   name = "Ghostty Config";
          tags = [ "terminal", "ghostty", "configuration" ];
          keyword = "ghosttyconfigzerebos";
          url = "https://ghostty.zerebos.com/";

}
{
   name = "Option Reference - Configuration";
          tags = [ "documentation", "configuration", "reference" ];
          keyword = "optionreference";
          url = "https://ghostty.org/docs/config/reference";

}
{
   name = "Ghostty Docs";
          tags = [ "documentation", "ghostty", "terminal" ];
          keyword = "ghosttydocs";
          url = "https://ghostty.org/docs";

}
{
   name = "Configuration - Wez's Terminal Emulator";
          tags = [ "terminal", "wezterm", "configuration" ];
          keyword = "weztermconfigdocs";
          url = "https://wezterm.org/config/files.html";

}
{
   name = "🔌 Plugin Spec | lazy.nvim";
          tags = [ "neovim", "plugins", "lua" ];
          keyword = "lazynvim";
          url = "https://lazy.folke.io/spec";

}
{
   name = "nvim-lualine/lualine.nvim: A blazing fast and easy to configure neovim statusline plugin written in pure lua.";
          tags = [ "neovim", "plugins", "statusline" ];
          keyword = "lualinenim";
          url = "https://github.com/nvim-lualine/lualine.nvim";

}
{
   name = "Overview | superfile";
          tags = [ "filemanager", "documentation" ];
          keyword = "superfile";
          url = "https://superfile.netlify.app/overview/";

}
{
   name = "Getting Started | fx";
          tags = [ "tools", "gettingstarted" ];
          keyword = "fxgettingstarted";
          url = "https://fx.wtf/getting-started";

}
{
   name = "Handbook - Pillow (PIL Fork) 11.3.0.dev0 documentation";
          tags = [ "python", "imageprocessing", "documentation" ];
          keyword = "pillowhandbook";
          url = "https://pillow.readthedocs.io/en/latest/handbook/index.html";

}
{
   name = "AnyBlock App";
          tags = [ "privacy", "blocking", "app" ];
          keyword = "anyblockapp";
          url = "https://any-block.github.io/any-block/";

}
{
   name = "Help - Neovim docs";
          tags = [ "neovim", "documentation", "help" ];
          keyword = "neovimhelp";
          url = "https://neovim.io/doc/user/index.html";

}
{
   name = "Read The Tao of tmux | Leanpub";
          tags = [ "tmux", "guide", "terminal" ];
          keyword = "taooftmux";
          url = "https://leanpub.com/the-tao-of-tmux/read#leanpub-auto-formats";

}
{
   name = "dylanaraps/pure-bash-bible: 📖 A collection of pure bash alternatives to external processes.";
          tags = [ "bash", "scripting", "github" ];
          keyword = "purebashbible";
          url = "https://github.com/dylanaraps/pure-bash-bible";

}
{
   name = "Fugitive.vim - a complement to command line git";
          tags = [ "vim", "git", "plugin" ];
          keyword = "fugitivevim";
          url = "http://vimcasts.org/episodes/fugitive-vim---a-complement-to-command-line-git/";

}
{
   name = "Crontab.guru - The cron schedule expression generator";
          tags = [ "linux", "cron", "tools" ];
          keyword = "crontabguru";
          url = "https://crontab.guru/#0_0_*_*_*";

}
{
   name = "R 4 DataScience";
          tags = [ "r", "datascience", "programming" ];
          keyword = "r4ds";
          url = "http://r4ds.had.co.nz/";

}
{
   name = "R 4 Data Science: Exercise Solutions";
          tags = [ "r", "datascience", "exercises" ];
          keyword = "r4dsexercises";
          url = "https://jrnold.github.io/r4ds-exercise-solutions/exploratory-data-analysis.html#variation";

}
{
   name = "The tidyverse style guide";
          tags = [ "r", "tidyverse", "styleguide" ];
          keyword = "tidyversestyle";
          url = "https://style.tidyverse.org/";

}
{
   name = "YaRrr! The Pirate’s Guide to R";
          tags = [ "r", "guide", "programming" ];
          keyword = "yarrr";
          url = "https://bookdown.org/ndphillips/YaRrr/who-is-this-book-for.html";

}
{
   name = "R Coding Style Best Practices";
          tags = [ "r", "codingstyle", "bestpractices" ];
          keyword = "rcodingstyle";
          url = "https://www.datanovia.com/en/blog/r-coding-style-best-practices/";

}
{
   name = "Colors (ggplot2)";
          tags = [ "r", "ggplot2", "colors" ];
          keyword = "ggplot2colors";
          url = "http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/";

}
{
   name = "A Grammar of Animated Graphics • gganimate";
          tags = [ "r", "ggplot2", "animation" ];
          keyword = "gganimate";
          url = "https://gganimate.com/";

}
{
   name = "A Layered Grammar of Graphics - layered-grammar.pdf";
          tags = [ "r", "graphics", "theory" ];
          keyword = "layeredgrammar";
          url = "http://vita.had.co.nz/papers/layered-grammar.pdf";

}
{
   name = "ggplot2: Elegant Graphics for Data Analysis";
          tags = [ "r", "ggplot2", "book" ];
          keyword = "ggplot2book";
          url = "https://ggplot2-book.org/";

}
{
   name = "Graphs";
          tags = [ "r", "graphics" ];
          keyword = "rgraphs";
          url = "http://www.cookbook-r.com/Graphs/";

}
{
   name = "Top 50 ggplot2 Visualizations - The Master List (With Full R Code)";
          tags = [ "r", "ggplot2", "visualizations" ];
          keyword = "ggplot2visualizations";
          url = "http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html";

}
{
   name = "R Color Styles";
          tags = [ "r", "colors", "style" ];
          keyword = "rcolorstyles";
          url = "https://bootstrappers.umassmed.edu/bootstrappers-courses/pastCourses/rCourse_2016-04/Additional_Resources/Rcolorstyle.html#named-colors";

}
{
   name = "Laying out multiple plots on a page";
          tags = [ "r", "plots", "layout" ];
          keyword = "rplotlayout";
          url = "https://cran.r-project.org/web/packages/egg/vignettes/Ecosystem.html";

}
{
   name = "Rcolor.pdf";
          tags = [ "r", "colors", "pdf" ];
          keyword = "rcolorpdf";
          url = "http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf";

}
{
   name = "R Linear Regression Tutorial - Door to master its working! - DataFlair";
          tags = [ "r", "linearregression", "tutorial" ];
          keyword = "rlinearregression";
          url = "https://data-flair.training/blogs/r-linear-regression-tutorial/";

}
{
   name = "Pluralsight Courses";
          tags = [ "education", "courses", "pluralsight" ];
          keyword = "pluralsightcourses";
          url = "https://www.pluralsight.com/product/skills?utm_term=&aid=701j0000002BGhbAAG&promo=&oid=&utm_source=branded&utm_medium=digital_paid_search_google&utm_campaign=ISR_Brand_E&utm_content=&gclid=Cj0KCQjwjcfzBRCHARIsAO-1_OoshWH8jjBkFIP3GPyARo9Fj1XlHKTmDeRx90GJ9-ZbPegBvLkZBzoaAlfXEALw_wcB";

}
{
   name = "DevOps: The Big Picture | Pluralsight";
          tags = [ "devops", "course", "pluralsight" ];
          keyword = "devopsbigpicture";
          url = "https://app.pluralsight.com/player?course=devops-big-picture&author=richard-seroter&name=24caaa04-2932-4633-abd0-b0cd4de0fc7c&clip=0&mode=live";

}
{
   name = "Improving your listening skills";
          tags = [ "softskills", "listening", "linkedinlearning" ];
          keyword = "improvinglistening";
          url = "https://www.linkedin.com/learning/improving-your-listening-skills-19238090/improving-your-listening-skills?u=0";

}
{
   name = "Getting started in building your product roadmap";
          tags = [ "productmanagement", "roadmap", "linkedinlearning" ];
          keyword = "productroadmap";
          url = "https://www.linkedin.com/learning/product-management-building-a-product-roadmap/getting-started-in-building-your-product-roadmap?u=0";

}
{
   name = "Become a product manager";
          tags = [ "productmanagement", "career", "linkedinlearning" ];
          keyword = "becomepm";
          url = "https://www.linkedin.com/learning/transitioning-to-product-management/become-a-product-manager-21968627?u=0";

}
{
   name = "Daily living as a leader";
          tags = [ "leadership", "softskills", "linkedinlearning" ];
          keyword = "dailyleadership";
          url = "https://www.linkedin.com/learning/20-habits-of-executive-leadership/daily-living-as-a-leader?save=true&u=0";

}
{
   name = "https://www.linkedin.com/learning/the-3-minute-rule-say-less-to-get-more/say-less-to-get-more?u=0";
          tags = [ "communication", "linkedinlearning" ];
          keyword = "3minuterule";
          url = "https://www.linkedin.com/learning/the-3-minute-rule-say-less-to-get-more/say-less-to-get-more?u=0";

}
{
   name = "My Path Dashboard | WorldQuant University";
          tags = [ "education", "finance", "quant" ];
          keyword = "wqumypath";
          url = "https://learn.wqu.edu/my-path";

}
{
   name = "WORTHBUY Stainless Steel Thermal Insulation Lunch Box With Spoon Student Office Works Bento Box Seal Leak Proof Food Containers - AliExpress";
          tags = [ "shopping", "kitchenware" ];
          keyword = "worthbuylunchbox";
          url = "https://www.aliexpress.com/item/1005006317423599.html?spm=a2g0o.productlist.main.5.1d89VSTVVSTVSi&algo_pvid=f95613d9-2ee5-4358-83f4-c7a12c19f9ff&algo_exp_id=f95613d9-2ee5-4358-83f4-c7a12c19f9ff-2&pdp_npi=4%40dis%21ILS%2192.50%2131.82%21%21%21174.92%2160.17%21%40211b801817061835842476814e10c1%2112000036829197702%21sea%21IL%21173306932%21&curPageLogUid=Di0NEAyu7XRM&utparam-url=scene%3Asearch%7Cquery_from%3A";

}
{
   name = "Rubik's cube solver app - Search";
          tags = [ "rubikscube", "solver", "app" ];
          keyword = "rubikscubesolver";
          url = "https://www.bing.com/search?q=Rubik%27s+cube+solver+app&qs=ds&form=CONVAJ&showconv=0";

}
{
   name = "> How to solve the Rubik's Cube - Beginners Method";
          tags = [ "rubikscube", "tutorial", "beginners" ];
          keyword = "rubikscubebeginner";
          url = "https://ruwix.com/the-rubiks-cube/how-to-solve-the-rubiks-cube-beginners-method/";

}
{
   name = "> Cubing Terminology - Abbreviations and Commonly Used Expressions";
          tags = [ "rubikscube", "terminology" ];
          keyword = "rubikscubeterms";
          url = "https://ruwix.com/the-rubiks-cube/cubing-terminology-abbreviations-commonly-used-expressions/";

}
{
   name = "> Different Rubik's Cube Solving Methods - Ruwix";
          tags = [ "rubikscube", "methods" ];
          keyword = "rubikscubemethods";
          url = "https://ruwix.com/the-rubiks-cube/different-rubiks-cube-solving-methods/";

}
{
   name = "> Rubik's Cube Algorithms - Ruwix";
          tags = [ "rubikscube", "algorithms" ];
          keyword = "rubikscubealgorithms";
          url = "https://ruwix.com/the-rubiks-cube/algorithm/";

}
{
   name = "> Online Rubik's Cube Solver";
          tags = [ "rubikscube", "solver", "online" ];
          keyword = "onlinerubikssolver";
          url = "https://rubiks-cube-solver.com/";

}
{
   name = "> Cubesolver";
          tags = [ "rubikscube", "solver", "app" ];
          keyword = "cubesolver";
          url = "https://cubesolver.app/en/tabs/home";

}
{
   name = "> מדריכים וכלים של פעמונים - paamonim";
          tags = [ "finance", "tools", "israel" ];
          keyword = "paamonimtools";
          url = "https://www.paamonim.org/he/%D7%9B%D7%9C%D7%99%D7%9D-%D7%95%D7%9E%D7%97%D7%A9%D7%91%D7%95%D7%A0%D7%99%D7%9D/";

}
{
   name = "> 11 צעדים איך להגיע לעצמאות כלכלית ופרישה מוקדמת | חתול פיננסי";
          tags = [ "finance", "financialindependence", "israel" ];
          keyword = "financialindependenceil";
          url = "https://moneyplan.co.il/11-%d7%a6%d7%a2%d7%93%d7%99%d7%9d-%d7%90%d7%99%d7%9a-%d7%9c%d7%94%d7%92%d7%99%d7%a2-%d7%9c%d7%a2%d7%a6%d7%9e%d7%90%d7%95%d7%aa-%d7%9b%d7%9c%d7%9b%d7%9c%d7%99%d7%aa-%d7%95%d7%a4%d7%a8%d7%99%d7%a9%d7%94/";

}
{
   name = "> ביטוח, פנסיה, גמל, חיסכון ושירותים פיננסיים | הראל ביטוח";
          tags = [ "finance", "insurance", "israel" ];
          keyword = "harelinsurance";
          url = "https://www.harel-group.co.il/Pages/default.aspx/";

}
{
   name = "> איך לחסוך כסף - 56 טיפים לחסכון | חתול פיננסי";
          tags = [ "finance", "savingmoney", "israel" ];
          keyword = "howtosavemoneyil";
          url = "https://moneyplan.co.il/%d7%90%d7%99%d7%9a-%d7%9c%d7%97%d7%a1%d7%95%d7%9a-%d7%9b%d7%a1%d7%a3/";

}
{
   name = "> חינוך פיננסי לילדים: תכינו את ילדכם להצלחה בעולם הפיננסי | חתול פיננסי";
          tags = [ "finance", "financialeducation", "kids", "israel" ];
          keyword = "financialeducationkidsil";
          url = "https://moneyplan.co.il/%d7%97%d7%99%d7%a0%d7%95%d7%9a-%d7%a4%d7%99%d7%a0%d7%a0%d7%a1%d7%99-%d7%9c%d7%99%d7%9c%d7%93%d7%99%d7%9d/";

}
{
   name = "> 12 עצות זהב לניהול תקציב הוצאות והכנסות וכלכלת משפחה | חתול פיננסי";
          tags = [ "finance", "budgeting", "familyfinance", "israel" ];
          keyword = "familybudgetil";
          url = "https://moneyplan.co.il/%d7%a0%d7%99%d7%94%d7%95%d7%9c-%d7%aa%d7%a7%d7%a6%d7%99%d7%91-%d7%94%d7%95%d7%a6%d7%90%d7%95%d7%aa-%d7%94%d7%9b%d7%a0%d7%a1%d7%95%d7%aa-%d7%9e%d7%a9%d7%a4%d7%97%d7%aa%d7%99-12-%d7%a2%d7%a6%d7%95%d7%aa/";

}
{
   name = "> קורס מקוון לניהול תקציב - paamonim";
          tags = [ "finance", "budgeting", "course", "israel" ];
          keyword = "budgetingcourseil";
          url = "https://www.paamonim.org/he/13223/";

}
{
   name = "free-programming-books/books/free-programming-books-langs.md at main · EbookFoundation/free-programming-books · GitHub";
          tags = [ "programming", "books", "free" ];
          keyword = "freeprogrammingbooks";
          url = "https://github.com/EbookFoundation/free-programming-books/blob/main/books/free-programming-books-langs.md#python";

}
{
   name = "Teach Yourself C in 24 Hours";
          tags = [ "cprogramming", "tutorial" ];
          keyword = "ctutorial24hours";
          url = "http://aelinik.free.fr/c/";

}
{
   name = "C Tutorial: Learn C Programming for Free";
          tags = [ "cprogramming", "tutorial", "free" ];
          keyword = "ctutorialfree";
          url = "https://www.tutorialspoint.com/cprogramming/index.htm";

}
{
   name = "Learning GNU C";
          tags = [ "cprogramming", "gnu", "book" ];
          keyword = "gnucbook";
          url = "https://www.nongnu.org/c-prog-book/online/";

}
{
   name = "The GNU C Reference Manual";
          tags = [ "cprogramming", "gnu", "manual" ];
          keyword = "gnucmanual";
          url = "https://www.gnu.org/software/gnu-c-manual/gnu-c-manual.html";

}
{
   name = "The Art of Unit Testing";
          tags = [ "softwaredevelopment", "testing", "book" ];
          keyword = "artofunittesting";
          url = "https://www.manning.com/books/the-art-of-unit-testing";

}
{
   name = "Department of Computer Science and Technology – Course pages 2018–19: Programming in C and C++ – Course materials";
          tags = [ "cprogramming", "cpp", "course" ];
          keyword = "cambridgec";
          url = "https://www.cl.cam.ac.uk/teaching/1819/ProgC/materials.html";

}
{
   name = "C Programming Reference Manual, Volume 1: Basic Implementation";
          tags = [ "cprogramming", "manual", "reference" ];
          keyword = "cprogrammingmanual";
          url = "https://public.support.unisys.com/aseries/docs/ClearPath-MCP-20.0/86002268-209/index.html";

}
{
   name = "CS 225 | Stack and Heap Memory";
          tags = [ "cprogramming", "memory", "cs" ];
          keyword = "cstackheap";
          url = "https://courses.grainger.illinois.edu/cs225/fa2023/resources/stack-heap/";

}
{
   name = "Printf - Syntax | Format specifier <- good site";
          tags = [ "cprogramming", "printf", "formatspecifier" ];
          keyword = "cprintf";
          url = "https://codesandtutorials.com/programming/c/basics/getstarted/printf-syntax-format_specifier.php";

}
{
   name = "C Class - Standard Input/Output Functions";
          tags = [ "cprogramming", "stdio", "functions" ];
          keyword = "cstdio";
          url = "https://user-web.icecube.wisc.edu/~dglo/c_class/stdio.html";

}
{
   name = "C Class - Index";
          tags = [ "cprogramming", "class", "index" ];
          keyword = "cclassindex";
          url = "https://user-web.icecube.wisc.edu/~dglo/c_class/index.html";

}
{
   name = "Using the GNU Compiler Collection (GCC)";
          tags = [ "cprogramming", "gcc", "compiler" ];
          keyword = "gccmanual";
          url = "https://gcc.gnu.org/onlinedocs/gcc/index.html#SEC_Contents";

}
{
   name = "Learn Touch Typing Free - TypingClub";
          tags = [ "typing", "education", "free" ];
          keyword = "typingclub";
          url = "https://www.typingclub.com/";

}
{
   name = "Vim cheatsheet - devhints";
          tags = [ "vim", "cheatsheet", "editor" ];
          keyword = "vimcheatsheet";
          url = "https://devhints.io/vim";

}
{
   name = "A Great Vim Cheat Sheet";
          tags = [ "vim", "cheatsheet", "editor" ];
          keyword = "vimgreatcheatsheet";
          url = "https://vimsheet.com/";

}
{
   name = "Vim Cheat Sheet";
          tags = [ "vim", "cheatsheet", "editor" ];
          keyword = "vimcheatsheetrtorr";
          url = "https://vim.rtorr.com/";

}
{
   name = "Index | uv - package manager";
          tags = [ "python", "packagemanager", "uv" ];
          keyword = "uvpackagemanager";
          url = "https://docs.astral.sh/uv/getting-started/";

}
{
   name = "NumPy: the absolute basics for beginners — NumPy v2.2 Manual";
          tags = [ "python", "numpy", "beginners" ];
          keyword = "numpymanual";
          url = "https://numpy.org/doc/2.2/user/absolute_beginners.html";

}
{
   name = "Automate the Boring Stuff with Python";
          tags = [ "python", "automation", "book" ];
          keyword = "automatetheboringstuff";
          url = "https://automatetheboringstuff.com/";

}
{
   name = "User Guide — pandas 2.2.3 documentation";
          tags = [ "python", "pandas", "documentation" ];
          keyword = "pandasuserguide";
          url = "https://pandas.pydata.org/docs/user_guide/index.html";

}
{
   name = "Data Structure Visualization";
          tags = [ "datastructures", "algorithms", "visualization" ];
          keyword = "datastructurevisualization";
          url = "https://www.cs.usfca.edu/~galles/visualization/Algorithms.html";

}
{
   name = "12. Binary search tree – Data Structures and Algorithms";
          tags = [ "datastructures", "algorithms", "binarytree" ];
          keyword = "binarysearchtree";
          url = "https://tira.mooc.fi/spring-2024/chap12/";

}
{
   name = "Lean Domain Search – Search for and register available domain names in seconds.";
          tags = [ "seo", "domains", "tools" ];
          keyword = "leandomainsearch";
          url = "https://leandomainsearch.com/";

}
{
   name = "Sample Size Calculator (Evan’s Awesome A/B Tools)";
          tags = [ "seo", "abtesting", "tools" ];
          keyword = "samplesizecalculator";
          url = "https://www.evanmiller.org/ab-testing/sample-size.html";

}
{
   name = "AeroFarms - An environmental champion, AeroFarms is leading the way to address our global food crisis by growing flavorful, healthy leafy greens in a sustainable and socially responsible way.";
          tags = [ "hydroponics", "agriculture", "verticalfarming" ];
          keyword = "aerofarms";
          url = "https://aerofarms.com/";

}
{
   name = "Green Automation";
          tags = [ "hydroponics", "automation", "agriculture" ];
          keyword = "greenautomation";
          url = "https://www.greenautomation.com/";

}
{
   name = "Viscon Hydroponics";
          tags = [ "hydroponics", "agriculture" ];
          keyword = "visconhydroponics";
          url = "https://www.visconhydroponics.eu/";

}
{
   name = "Automation and Robotics Used in Hydroponic System | IntechOpen";
          tags = [ "hydroponics", "automation", "robotics" ];
          keyword = "hydroponicautomation";
          url = "https://www.intechopen.com/books/urban-horticulture-necessity-of-the-future/automation-and-robotics-used-in-hydroponic-system";

}
{
   name = "AEssenseGrows Commercial Aeroponic Hydroponic Systems";
          tags = [ "hydroponics", "aeroponics", "commercial" ];
          keyword = "aessensegrows";
          url = "https://www.aessensegrows.com/";

}
{
   name = "Urban Crop Solutions";
          tags = [ "hydroponics", "verticalfarming" ];
          keyword = "urbancropsolutions";
          url = "https://urbancropsolutions.com/";

}
{
   name = "Farm.One - Weekly Salad Greens Subscription in NYC";
          tags = [ "hydroponics", "verticalfarming", "nyc" ];
          keyword = "farmone";
          url = "https://farm.one/";

}
{
   name = "Agriculture Solutions - Intelligent Growth Solutions";
          tags = [ "hydroponics", "agriculture", "solutions" ];
          keyword = "agriculturesolutions";
          url = "https://www.intelligentgrowthsolutions.com/use-cases-agri/#agri2";

}
{
   name = "Badia Farms";
          tags = [ "hydroponics", "verticalfarming" ];
          keyword = "badiafarms";
          url = "https://www.badiafarms.com/";

}
{
   name = "Sananbio US";
          tags = [ "hydroponics", "verticalfarming" ];
          keyword = "sananbious";
          url = "https://www.sananbious.com/";

}
{
   name = "\"We want to raise awareness on vertical farming in Italy\"";
          tags = [ "verticalfarming", "italy", "awareness" ];
          keyword = "verticalfarmingitaly";
          url = "https://www.hortidaily.com/article/9237129/we-want-to-raise-awareness-on-vertical-farming-in-italy/";

}
{
   name = "Vertical Farming | Lite+Fog | Germany";
          tags = [ "verticalfarming", "germany" ];
          keyword = "liteandfog";
          url = "https://www.liteandfog.com/";

}
{
   name = "VeggiTech – Advanced Farming";
          tags = [ "verticalfarming", "agriculture" ];
          keyword = "veggitech";
          url = "https://www.veggitech.com/";

}
{
   name = "AGRITECTURE";
          tags = [ "verticalfarming", "agriculture" ];
          keyword = "agritecture";
          url = "https://www.agritecture.com/";

}
{
   name = "Home - Association for Vertical Farming";
          tags = [ "verticalfarming", "association" ];
          keyword = "avf";
          url = "https://vertical-farming.net/";

}
{
   name = "Techno Farm™";
          tags = [ "verticalfarming", "agriculture" ];
          keyword = "technofarm";
          url = "https://technofarm.com/en/";

}
{
   name = "Indoor vertical farming (hydroponic) solutions | Urban Crop Solutions";
          tags = [ "verticalfarming", "hydroponics", "solutions" ];
          keyword = "urbancropsolutionshydro";
          url = "https://urbancropsolutions.com/solutions/";

}
{
   name = "AEtrium-SmartFarm - Fully Automated Vertical Stacked Aeroponic Farm";
          tags = [ "aeroponics", "automation", "verticalfarming" ];
          keyword = "aetriumsmarfarm";
          url = "https://www.aessensegrows.com/en/fresh/aetrium-smartfarm";

}
{
   name = "Wallfarm – Intelligent agriculture nutrient dosing";
          tags = [ "hydroponics", "automation", "nutrients" ];
          keyword = "wallfarm";
          url = "https://wallfarm.bio/";

}
{
   name = "FARMINOVA - Plant Factory";
          tags = [ "verticalfarming", "plantfactory" ];
          keyword = "farminova";
          url = "https://www.farminova.com/En";

}
{
   name = "CERT1763-Corporate brochure nieuw 8LR EN.pdf";
          tags = [ "agriculture", "brochure", "pdf" ];
          keyword = "certhonbrochure";
          url = "https://www.certhon.com/downloads/content/4093/8d88ad6a294f270/CERT1763-Corporate%20brochure%20nieuw%208LR%20EN.pdf";

}
{
   name = "Technology — Crop One";
          tags = [ "verticalfarming", "technology" ];
          keyword = "cropone";
          url = "https://cropone.ag/technology";

}
{
   name = "Voeks Inc. — Vertical Hydroponic Design";
          tags = [ "hydroponics", "design", "verticalfarming" ];
          keyword = "voeksinc";
          url = "https://www.voeksinc.com/vertical-hydroponic-design";

}
{
   name = "Vertical Farming Overview — HYVE® Indoor Farming Systems | Hydroponic Solutions";
          tags = [ "verticalfarming", "hydroponics", "systems" ];
          keyword = "hyvefarming";
          url = "https://growhyve.com/vertical-farming-overview";

}
{
   name = "Plant Spacing Calculator";
          tags = [ "gardening", "calculator", "plants" ];
          keyword = "plantspacing";
          url = "https://www.omnicalculator.com/construction/plants";

}
{
   name = "Sizing a hydroponic system | Growers Supply";
          tags = [ "hydroponics", "sizing", "guide" ];
          keyword = "hydroponicsizing";
          url = "https://growerssupply.wordpress.com/2016/05/31/sizing-a-hydroponic-system/";

}
{
   name = "Water Soluble Fertilizer Calculator";
          tags = [ "gardening", "fertilizer", "calculator" ];
          keyword = "fertilizercalculator";
          url = "https://www.omnicalculator.com/construction/water-soluble-fertilizer";

}
{
   name = "Alan Bartlett and Sons | Quality Parsnips";
          tags = [ "agriculture", "produce", "parsnips" ];
          keyword = "alanbartlett";
          url = "https://alanbartlettandsons.co.uk/our-produce/parsnips/";

}
{
   name = "Contact Us - Burgess Farm Produce";
          tags = [ "agriculture", "produce", "contact" ];
          keyword = "burgessfarm";
          url = "http://www.burgessfarmproduce.co.uk/contact-us/";

}
{
   name = "Contact - British Organic Carrots";
          tags = [ "agriculture", "organic", "carrots" ];
          keyword = "britishorganiccarrots";
          url = "http://britishorganiccarrots.co.uk/contact/";

}
{
   name = "Carrots - Strawson LTD";
          tags = [ "agriculture", "carrots" ];
          keyword = "strawsoncarrots";
          url = "https://strawsons.com/carrots/";

}
{
   name = "Contact Us – Kettle Produce";
          tags = [ "agriculture", "produce", "contact" ];
          keyword = "kettleproduce";
          url = "http://kettle.co.uk/contact-us/";

}
{
   name = "Roots";
          tags = [ "agriculture", "produce", "roots" ];
          keyword = "huntapacroots";
          url = "http://www.huntapac.co.uk/roots/";

}
{
   name = "Carrots";
          tags = [ "agriculture", "carrots", "prepared" ];
          keyword = "alfredgpearcecarrots";
          url = "https://www.alfredgpearce.co.uk/prepared-vegetables/carrots/";

}
{
   name = "Products | Freshgro";
          tags = [ "agriculture", "produce", "products" ];
          keyword = "freshgroproducts";
          url = "https://www.freshgro.co.uk/category/products/";

}
{
   name = "RRW Bartlett";
          tags = [ "agriculture", "produce" ];
          keyword = "rrwbartlett";
          url = "https://rrwbartlett.co.uk/our-produce/";

}
{
   name = "Carrot grower — Hobson Farming | British carrot grower and farmer";
          tags = [ "agriculture", "carrots", "farming" ];
          keyword = "hobsonfarming";
          url = "https://www.hobsonfarming.co.uk/carrot-grower";

}
{
   name = "http://www.abrey-farms.co.uk/carrots.asp";
          tags = [ "agriculture", "carrots" ];
          keyword = "abreyfarmscarrots";
          url = "http://www.abrey-farms.co.uk/carrots.asp";

}
{
   name = "(1) LinkedIn";
          tags = [ "linkedin", "socialmedia" ];
          keyword = "linkedinabreyfarms";
          url = "https://www.linkedin.com/sharing/share-offsite/?url=http%3A%2F%2Fwww.abrey-farms.co.uk%2Fcarrots.asp";

}
{
   name = "Vegatable Producer Bromham, Wiltshire, Bunched Carrots";
          tags = [ "agriculture", "carrots", "producer" ];
          keyword = "pagetsproduce";
          url = "https://www.pagetsproduce.co.uk/availability.html";

}
{
   name = "BridgeFarm Group";
          tags = [ "agriculture", "plants" ];
          keyword = "bridgefarmgroup";
          url = "https://www.bridgefarmgroup.co.uk/products/outdoor-plants/";

}
{
   name = "Gallery - Suffolk Produce Ltd";
          tags = [ "agriculture", "gallery" ];
          keyword = "suffolkproducegallery";
          url = "http://www.suffolkproduce.co.uk/gallery.html";

}
{
   name = "Coming Soon Page";
          tags = [ "agriculture", "website" ];
          keyword = "benzies";
          url = "https://www.benzies.co.uk/";

}
{
   name = "Carrots";
          tags = [ "agriculture", "carrots" ];
          keyword = "poskittcarrots";
          url = "https://poskittcarrots.co.uk/farm/carrots";

}
{
   name = "Our products | Dutch Carrot Group";
          tags = [ "agriculture", "carrots", "products" ];
          keyword = "dutchcarrotgroup";
          url = "https://www.dutchcarrotgroup.nl/our-products?lang=en";

}
{
   name = "HEEGSMA BV, Vegetables, edible roots and tubers, Fruits and vegetables - import-export, Onions, on EUROPAGES.";
          tags = [ "agriculture", "vegetables", "importexport" ];
          keyword = "heegsmabv";
          url = "https://www.europages.co.uk/HEEGSMA-BV/NLD123014-00101.html";

}
{
   name = "Australian Exporters - Searching for: \"Carrot\"";
          tags = [ "agriculture", "australia", "exporters" ];
          keyword = "australiancarrotsexporters";
          url = "http://www.australianexporters.net/AExportersSearch/?term=carrot";

}
{
   name = "Arahura Farms - Certified organic carrot growers/packers - Australian Exporters";
          tags = [ "agriculture", "organic", "carrots", "australia" ];
          keyword = "arahurafarms";
          url = "http://www.australianexporters.net/companyID48400.htm";

}
{
   name = "Field Fresh Tasmania - Onions, carrots - Australian Exporters";
          tags = [ "agriculture", "onions", "carrots", "australia" ];
          keyword = "fieldfreshtasmania";
          url = "http://www.australianexporters.net/companyID2601.htm";

}
{
   name = "Geoffrey Thompson & Growers Co-operative Co Pty Ltd - Pears, grapes, apples, carrots, citrus fruits - Australian Exporters";
          tags = [ "agriculture", "fruits", "vegetables", "australia" ];
          keyword = "geoffreythompson";
          url = "http://www.australianexporters.net/companyID2875.htm";

}
{
   name = "L & G Gazzola & Sons Pty Ltd - Celery, lettuce, asian vegetables, broccolli, carrots, parsnips - Australian Exporters";
          tags = [ "agriculture", "vegetables", "australia" ];
          keyword = "gazzolaandsons";
          url = "http://www.australianexporters.net/companyID3922.htm#contactdetails";

}
{
   name = "Patane Produce (WA) Pty Ltd - Vegetables, primarily Carrots, Onions, Potatoes and Broccoli - Australian Exporters";
          tags = [ "agriculture", "vegetables", "australia" ];
          keyword = "pataneproduce";
          url = "http://www.australianexporters.net/companyID8669.htm";

}
{
   name = "Australian Suppliers Directory - Austrade";
          tags = [ "australia", "suppliers", "directory" ];
          keyword = "austradesuppliers";
          url = "https://www.austrade.gov.au/SupplierDetails.aspx?ORGID=ORG0000016388&folderid=1736";

}
{
   name = "Mehr über HLB - HLB research and consultancy in agriculture";
          tags = [ "agriculture", "research", "consultancy" ];
          keyword = "hlbagriculture";
          url = "https://www.hlbbv.nl/index.php/de/";

}
{
   name = "Die AMI | AMI | Über uns | AMI | natürlich informiert";
          tags = [ "agriculture", "germany", "information" ];
          keyword = "amiinformiert";
          url = "https://www.ami-informiert.de/ueber-die-ami";

}
{
   name = "Hazera_2018-19-Catalogue.pdf";
          tags = [ "agriculture", "seeds", "catalogue" ];
          keyword = "hazeracatalogue";
          url = "https://static1.squarespace.com/static/5ea63e770ba57d40620339d9/t/5ea76def25ab4e20b23703bf/1588030991990/Hazera_2018-19-Catalogue.pdf";

}
{
   name = "Agriculture companies in Belgium";
          tags = [ "agriculture", "belgium", "companies" ];
          keyword = "belgiumagriculture";
          url = "https://companylist.org/Belgium/Agriculture/";

}
{
   name = "Fresh Carrots companies in the United States";
          tags = [ "agriculture", "carrots", "usa" ];
          keyword = "usfreshcarrots";
          url = "https://companylist.org/United_States/Agriculture/Fresh_Vegetables/Fresh_Carrots/";

}
{
   name = "Veco BV - Parisian carrots";
          tags = [ "agriculture", "carrots", "netherlands" ];
          keyword = "vecoparisiancarrots";
          url = "https://www.vecobv.nl/en/";

}
{
   name = "World Markets for Organic Fruit and Vegetables";
          tags = [ "agriculture", "organic", "markets" ];
          keyword = "organicfruitvegmarkets";
          url = "http://www.fao.org/3/y1669e/y1669e00.htm#Contents";

}
{
   name = "New Age Provisions Webinar - Thank You | Freight Farms";
          tags = [ "verticalfarming", "webinar", "freightfarms" ];
          keyword = "freightfarmswebinar";
          url = "https://www.freightfarms.com/new-age-provisions-webinar-thank-you?utm_campaign=Nov.%202020%20-%20New%20Age%20Provisions%20Webinar&utm_medium=email&_hsmi=100141007&_hsenc=p2ANqtz-9farkncVr9_JC_wdbY4yOCRr_Iyvw5r76Qn37rFE-bae8QpX1-gGe-Z0WLZH1je72BZ0tWSknxT1goiA2p0sG-MTM5HQ&utm_content=100141007&utm_source=hs_email";

}
{
   name = "Opportunities & Risks - Idaho University";
          tags = [ "mushrooms", "agriculture", "research" ];
          keyword = "shroomsopportunities";
          url = "https://www.extension.uidaho.edu/publishing/pdf/CIS/CIS1077.pdf";

}
{
   name = "Mushroom_12_DEF.indd - i0522e.pdf";
          tags = [ "mushrooms", "pdf", "agriculture" ];
          keyword = "mushroompdf";
          url = "http://www.fao.org/3/i0522e/i0522e.pdf";

}
{
   name = "אירגון מידע לפי עיר (1).xlsx - Google Sheets";
          tags = [ "slums", "data", "googlesheets" ];
          keyword = "slumsdata";
          url = "https://docs.google.com/spreadsheets/d/1c0dZY-pqTWdcSgTpI7chJR524f1jNVKr/edit#gid=71517364";

}
{
   name = "Réglementation relative à l’occupation et à l’entretien des bâtiments - Outils de réglementation - Ministère des Affaires municipales et de l'Habitation";
          tags = [ "slums", "regulation", "housing" ];
          keyword = "housingregulation";
          url = "https://www.mamh.gouv.qc.ca/amenagement-du-territoire/guide-la-prise-de-decision-en-urbanisme/reglementation/reglementation-relative-a-loccupation-et-a-lentretien-des-batiments/";

}
{
   name = "Ministerium für Gehäuse at DuckDuckGo";
          tags = [ "slums", "housing", "government" ];
          keyword = "housingministry";
          url = "https://duckduckgo.com/?q=Ministerium+f%C3%BCr+Geh%C3%A4use&t=lm&atb=v158-1&ia=web";

}
{
   name = "Definition MoLGH: Ministerium der lokalen Regierung und Gehäuse - Ministry of Local Government and Housing";
          tags = [ "slums", "government", "housing" ];
          keyword = "molghdefinition";
          url = "https://www.abbreviationfinder.org/de/acronyms/molgh_ministry-of-local-government-and-housing.html";

}
{
   name = "Server Not Found";
          tags = [ "slums", "news" ];
          keyword = "servernotfound";
          url = "https://newsde.eu/2020/07/30/das-ministerium-sagte-die-menge-des-geldes-zu-loesen-das-gehaeuse-problem-der-behinderten/";

}
{
   name = "Ponte-Tower in Johannesburg: \"Afrikas gefährlichstes Hochhaus\" wird Touristenmagnet - ZDFheute";
          tags = [ "slums", "johannesburg", "architecture" ];
          keyword = "pontetower";
          url = "https://www.zdf.de/nachrichten/panorama/suedafrika-ponte-tower-johannesburg-touristenattraktion-100.html";

}
{
   name = "Institut der Stadtbaukunst – Ein Forum für Architektur und Städtebau";
          tags = [ "architecture", "urbanplanning", "institute" ];
          keyword = "stadtbaukunst";
          url = "https://www.stadtbaukunst.org/deutsch/staedtebaulehre/seminare/mythoshochhaus/index.html?tid=516&btid=69";

}
{
   name = "Die Zukunft der Städte: Jeder sechste Erdbewohner lebt im Slum - Sachbuch - FAZ";
          tags = [ "slums", "urbanization", "future" ];
          keyword = "futureofcities";
          url = "https://www.faz.net/aktuell/feuilleton/buecher/rezensionen/sachbuch/die-zukunft-der-staedte-jeder-sechste-erdbewohner-lebt-im-slum-1438571.html";

}
{
   name = "Die Slums von Madrid | Europa | DW | 03.09.2012";
          tags = [ "slums", "madrid", "europe" ];
          keyword = "madridslums";
          url = "https://www.dw.com/de/die-slums-von-madrid/a-16211944";

}
{
   name = "Was Architektur im Slum bewegen kann";
          tags = [ "slums", "architecture", "impact" ];
          keyword = "slumarchitecture";
          url = "https://www.oeaw.ac.at/detail/news/was-architektur-im-slum-bewegen-kan/";

}
{
   name = "Städtische Slums: Wie und warum sie entstehen";
          tags = [ "slums", "urbanplanning", "causes" ];
          keyword = "urbanslums";
          url = "https://www.greelane.com/geisteswissenschaften/erdkunde/massive-urban-slums-1435765/";

}
{
   name = "Mauer soll Jakarta schützen: Wie eine Millionenstadt im Meer versinkt - n-tv.de";
          tags = [ "jakarta", "urbanplanning", "climatechange" ];
          keyword = "jakartasinking";
          url = "https://www.n-tv.de/panorama/Wie-eine-Millionenstadt-im-Meer-versinkt-article21424103.html";

}
{
   name = "Time Tracking Software - Free Automated Time Tracker TimeCamp";
          tags = [ "productivity", "software", "timetracking" ];
          keyword = "timecamp";
          url = "https://www.timecamp.com/";

}
{
   name = "Google Translate";
          tags = [ "translation", "google" ];
          keyword = "googletranslate";
          url = "https://translate.google.com/?sl=auto&tl=de&text=Minist%C3%A8re%20des%20Affaires%20municipales%0Aet%20de%20l%27Habitation&op=translate";

}
{
   name = "Inkscape tutorial: Basic | Inkscape";
          tags = [ "design", "inkscape", "tutorial" ];
          keyword = "inkscapetutorial";
          url = "https://inkscape.org/doc/tutorials/basic/tutorial-basic.html";

}
{
   name = "Create word clouds – WordItOut";
          tags = [ "tools", "wordcloud", "design" ];
          keyword = "worditout";
          url = "https://worditout.com/word-cloud/create";

}
{
   name = "TagCrowd: create your own word cloud from any text";
          tags = [ "tools", "wordcloud", "design" ];
          keyword = "tagcrowd";
          url = "https://tagcrowd.com/";

}
{
   name = "Word Art - Edit - WordArt.com";
          tags = [ "tools", "wordart", "design" ];
          keyword = "wordart";
          url = "https://wordart.com/create";

}
{
   name = "GitHub - GeekMagicClock/smalltv-pro: PRO version of GeekMagic smalltv";
          tags = [ "github", "project", "tv" ];
          keyword = "smalltvpro";
          url = "https://github.com/GeekMagicClock/smalltv-pro?type%3D6%26list_name%3D%E6%9C%AA%E5%91%BD%E5%90%8D";

}
{
   name = "Start-Up Nation Finder";
          tags = [ "jobsearch", "startup", "israel" ];
          keyword = "startupnationfinder";
          url = "https://finder.startupnationcentral.org/";

}
{
   name = "סטארטאפ והון סיכון | גיקטיים";
          tags = [ "startup", "venturecapital", "israel" ];
          keyword = "geektime";
          url = "https://www.geektime.co.il/category/startup/";

}
{
   name = "GCC - Gvahim Career Center - Gvahim";
          tags = [ "jobsearch", "careercenter", "israel" ];
          keyword = "gvahimcareercenter";
          url = "https://gvahim.org.il/gavhim-career-center/";

}
{
   name = "Israel Companies · Bessemer Venture Partners";
          tags = [ "venturecapital", "israel", "companies" ];
          keyword = "bvpcompanies";
          url = "https://www.bvp.com/israelcompanies#israel";

}
{
   name = "Home | Giza Venture Capital";
          tags = [ "venturecapital", "israel" ];
          keyword = "gizavc";
          url = "https://www.gizavc.com/";

}
{
   name = "Sequoia - Companies";
          tags = [ "venturecapital", "companies" ];
          keyword = "sequoiacompanies";
          url = "https://www.sequoiacap.com/israel/companies/";

}
{
   name = "YL Ventures - From Seed to Lead";
          tags = [ "venturecapital", "cybersecurity" ];
          keyword = "ylventures";
          url = "https://www.ylventures.com/";

}
{
   name = "Viola - Portfolio";
          tags = [ "venturecapital", "portfolio" ];
          keyword = "violaportfolio";
          url = "https://www.viola-group.com/portfolio/?industry=&fund=&search=&activeexit=Active&thePage=1";

}
{
   name = "Israel Companies · Bessemer Venture Partners";
          tags = [ "venturecapital", "israel", "companies" ];
          keyword = "bvpcompanies";
          url = "https://www.bvp.com/israelcompanies";

}
{
   name = "TLV Partners";
          tags = [ "venturecapital", "israel" ];
          keyword = "tlvpartners";
          url = "https://www.tlv.partners/#COMPANIES";

}
{
   name = "הפרודקטיבית – על ניהול מוצר, חיפוש עבודה והתובנות שביניהם";
          tags = [ "productmanagement", "jobsearch", "blog" ];
          keyword = "haproductivit";
          url = "https://haproductivit.com/";

}
{
   name = "Mind the Product - Conferences, training, and content for the world’s largest community of product managers, designers, and developers.";
          tags = [ "productmanagement", "community", "training" ];
          keyword = "mindtheproduct";
          url = "https://www.mindtheproduct.com/";

}
{
   name = "Create Magazine | בית הספר לחווית משתמש, UX, ניהול מוצר וחווית משתמש";
          tags = [ "ux", "productmanagement", "magazine" ];
          keyword = "createmagazine";
          url = "https://www.createmagazine.co.il/";

}
{
   name = "The Ultimate Guide to 37 Product Management Prioritization Frameworks";
          tags = [ "productmanagement", "frameworks", "guide" ];
          keyword = "pmframeworks";
          url = "https://www.productplan.com/product-management-frameworks/";

}
{
   name = "The Ultimate Product Management Framework to Help You Build the Right Product | Infinity";
          tags = [ "productmanagement", "framework", "guide" ];
          keyword = "ultimatepmframework";
          url = "https://startinfinity.com/product-management-framework";

}
{
   name = "How To Optimize Your LinkedIn Profile for Product Manager Recruiters";
          tags = [ "linkedin", "jobsearch", "productmanagement" ];
          keyword = "linkedinpmoptimize";
          url = "https://dailyproductprep.com/blog/how-to-optimize-your-linked-profile-for-product-manager-recruiters";

}
{
   name = "Wix.com Tel Aviv";
          tags = [ "jobs", "telaviv", "tech" ];
          keyword = "wixjobs";
          url = "https://www.wix.com/jobs/locations/tel-aviv";

}
{
   name = "Amazing Job Opportunities @ Fiverr.com";
          tags = [ "jobs", "telaviv", "freelance" ];
          keyword = "fiverrjobs";
          url = "https://www.fiverr.com/jobs/offices/tlv";

}
{
   name = "Tel Aviv, Israel | Amazon.jobs";
          tags = [ "jobs", "telaviv", "amazon" ];
          keyword = "amazonjobs";
          url = "https://jobs-us-west.amazon.com/en/locations/tel-aviv-israel";

}
{
   name = "Google Careers";
          tags = [ "jobs", "telaviv", "google" ];
          keyword = "googlecareers";
          url = "https://careers.google.com/jobs/results/?company=Google&company=Google%20Fiber&company=YouTube&employment_type=FULL_TIME&hl=en_US&jlo=en_US&location=Israel&q=&sort_by=relevance";

}
{
   name = "Facebook Job Openings | Facebook Careers | Facebook Careers";
          tags = [ "jobs", "telaviv", "facebook" ];
          keyword = "facebookjobs";
          url = "https://www.facebook.com/careers/jobs/?offices[0]=Tel%20Aviv%2C%20Israel";

}
{
   name = "Secret Tel Aviv Jobs - Product Manager";
          tags = [ "jobs", "telaviv", "productmanager" ];
          keyword = "secrettelavivpm";
          url = "https://jobs.secrettelaviv.com/list/category/product-manager/";

}
{
   name = "Riskified Careers";
          tags = [ "jobs", "telaviv", "tech" ];
          keyword = "riskifiedcareers";
          url = "https://www.riskified.com/careers/";

}
{
   name = "Jobs at Moovit";
          tags = [ "jobs", "telaviv", "tech" ];
          keyword = "moovitjobs";
          url = "https://www.comeet.com/jobs/moovit/63.007";

}
{
   name = "WalkMe Jobs : Open Positions - WalkMe™";
          tags = [ "jobs", "telaviv", "tech" ];
          keyword = "walkmejobs";
          url = "https://www.walkme.com/careers/careers_list/?region=emea";

}
{
   name = "Careers | Strategy& Israel";
          tags = [ "jobs", "telaviv", "consulting" ];
          keyword = "strategyandcareers";
          url = "https://www.strategyand.pwc.com/il/en/careers.html";

}
{
   name = "19 examples of STAR interview questions (plus how to answer them using STAR method)";
          tags = [ "interviews", "star", "career" ];
          keyword = "starinterview";
          url = "https://www.theladders.com/career-advice/a-guide-to-the-star-method";

}
{
   name = "30 Behavioral Interview Questions to Prepare For (with Example Answers) | Indeed.com";
          tags = [ "interviews", "behavioral", "career" ];
          keyword = "behavioralinterview";
          url = "https://www.indeed.com/career-advice/interviewing/most-common-behavioral-interview-questions-and-answers";

}
{
   name = "12 Difficult Behavioral Interview Questions - InterviewPenguin.com";
          tags = [ "interviews", "behavioral", "difficult" ];
          keyword = "difficultbehavioral";
          url = "https://interviewpenguin.com/behavioral-interview-questions-and-answers/";

}
{
   name = "4 Simple Strategies on How to Overcome Job Interview Stress";
          tags = [ "interviews", "stress", "tips" ];
          keyword = "interviewstress";
          url = "https://interviewpenguin.com/how-to-overcome-interview-nerves/";

}
{
   name = "15 Most Common Interview Questions and Answers for 2020";
          tags = [ "interviews", "commonquestions" ];
          keyword = "commoninterviewquestions";
          url = "https://interviewpenguin.com/interview-questions-and-answers/";

}
{
   name = "How to Respond to Interview Questions About Teamwork";
          tags = [ "interviews", "teamwork", "softskills" ];
          keyword = "teamworkinterview";
          url = "https://www.thebalancecareers.com/how-to-respond-to-interview-questions-about-teamwork-2061100";

}
{
   name = "Interview Question: \"What Do You Hope to Accomplish Here?\"";
          tags = [ "interviews", "careergoals" ];
          keyword = "accomplishhere";
          url = "https://www.thebalancecareers.com/what-can-we-expect-from-you-in-the-first-60-days-2061099";

}
{
   name = "Getting Started with Amazon Web Services (AWS)";
          tags = [ "aws", "cloud", "gettingstarted" ];
          keyword = "awsgettingstarted";
          url = "https://aws.amazon.com/getting-started/?sc_channel=em&sc_campaign=wlcm&sc_publisher=aws&sc_medium=em_wlcm_1&sc_detail=wlcm_1d&sc_content=other&sc_country=global&sc_geo=global&sc_category=mult&ref_=pe_1679150_261538020";

}
{
   name = "Fundamental Cloud Concepts for AWS - Pluralsight";
          tags = [ "aws", "cloud", "pluralsight" ];
          keyword = "awscloudconcepts";
          url = "https://app.pluralsight.com/courses/dfafd3ec-a172-4f7c-9fa2-7a230f96ec3c/table-of-contents";

}
{
   name = "AWS Cloud Practitioner Essentials | AWS Training & Certification";
          tags = [ "aws", "certification", "training" ];
          keyword = "awscloudpractitioner";
          url = "https://www.aws.training/Details/eLearning?id=60697";

}
{
   name = "Overview of Amazon Web Services - AWS Whitepaper - aws-overview.pdf";
          tags = [ "aws", "whitepaper", "overview" ];
          keyword = "awsoverviewpdf";
          url = "https://docs.aws.amazon.com/whitepapers/latest/aws-overview/aws-overview.pdf";

}
{
   name = "Overview of Amazon Web Services - aws-overview.pdf";
          tags = [ "aws", "whitepaper", "overview" ];
          keyword = "awsoverviewpdf2";
          url = "https://d0.awsstatic.com/whitepapers/aws-overview.pdf";

}
{
   name = "21 Important List of AWS Services you must know | DEVOPS MY WAY";
          tags = [ "aws", "services", "devops" ];
          keyword = "awsserviceslist";
          url = "https://devopsmyway.com/list-of-aws-services/";

}
{
   name = "AWS 101: Overview of Amazon Web Services";
          tags = [ "aws", "overview", "basics" ];
          keyword = "aws101";
          url = "https://www.sumologic.com/insight/aws/";

}
{
   name = "BCG - Case Library";
          tags = [ "consulting", "caseinterview", "bcg" ];
          keyword = "bcgcaselibrary";
          url = "https://icl.bcg.com/";

}
{
   name = "Math Training Prototype - Math Test";
          tags = [ "caseinterview", "math", "training" ];
          keyword = "casemath";
          url = "https://www.caseinterview.com/math/mathtest.php";

}
{
   name = "How to synthesize your findings | CaseCoach";
          tags = [ "caseinterview", "synthesis", "casecoach" ];
          keyword = "casesynthesis";
          url = "https://casecoach.com/courses/interview-prep-course-for-bcg/modules/learn-how-to-shape-and-communicate-your-answer-2/class/how-to-synthesize-your-findings-1/";

}
{
   name = "Exhibit Drills #1 | CaseCoach";
          tags = [ "caseinterview", "drills", "casecoach" ];
          keyword = "caseexhibitdrills";
          url = "https://casecoach.com/courses/interview-prep-course-for-bcg/modules/practice-practice-practice-3/class/exhibit-drills-1-2/";

}
{
   name = "RuTracker.org - ROCK";
          tags = [ "music", "download", "rock" ];
          keyword = "rutrackerrock";
          url = "https://rutracker.org/forum/viewforum.php?f=1698";

}
{
   name = "RuTracker.org - Electronic music (digitizing)";
          tags = [ "music", "download", "electronic" ];
          keyword = "rutrackerelectronic";
          url = "https://oodixxdcsthfjpmzpthnxt3kzu--rutracker-org.translate.goog/forum/viewforum.php?f=1754";

}
{
   name = "RuTracker.org - Electronic music (Hi-Res stereo)";
          tags = [ "music", "download", "hires", "electronic" ];
          keyword = "rutrackerhireselectronic";
          url = "https://rutracker.org/forum/viewforum.php?f=1893";

}
{
   name = "RuTracker.org - Music of different genres (Hi-Res stereo and multichannel music)";
          tags = [ "music", "download", "hires", "multichannel" ];
          keyword = "rutrackerhiresmultichannel";
          url = "https://rutracker.org/forum/viewforum.php?f=2512";

}
{
   name = "RuTracker.org - Rock music (Hi-Res stereo)";
          tags = [ "music", "download", "hires", "rock" ];
          keyword = "rutrackerhiresrock";
          url = "https://rutracker.org/forum/viewforum.php?f=1755";

}
{
   name = "RuTracker.org - Jazz and Blues (Hi-Res stereo)";
          tags = [ "music", "download", "hires", "jazz", "blues" ];
          keyword = "rutrackerhiresjazzblues";
          url = "https://rutracker.org/forum/viewforum.php?f=2302";

}
{
   name = "RuTracker.org - Digitized ALL";
          tags = [ "music", "download", "digitized" ];
          keyword = "rutrackerdigitized";
          url = "https://rutracker.org/forum/viewforum.php?f=2219";

}
{
   name = "MVGroup (Powered by Invision Power Board)";
          tags = [ "forum", "community" ];
          keyword = "mvgroup";
          url = "https://forums.mvgroup.org/";

}
{
   name = "CLAS all methods";
          tags = [ "baking", "bread" ];
          keyword = "brotgostclas";
          url = "https://brotgost.blogspot.com/2017/08/iii.html";

}
{
   name = "Pluralsight LinkedIn";
          tags = [ "pluralsight", "linkedin" ];
          keyword = "pluralsightlinkedin";
          url = "https://app.pluralsight.com/course-player?clipId=30e90fb9-a6c9-40ba-8dbf-50f39ddea77b";

}
{
   name = "Unicode Text Converter";
          tags = [ "tools", "textconverter", "unicode" ];
          keyword = "unicodetextconverter";
          url = "https://qaz.wtf/u/convert.cgi?text=goal-oriented";

}
{
   name = "LinkedIn Text Formatter » LinkedIn Makeover: LinkedIn Profile Optimization";
          tags = [ "linkedin", "tools", "formatter" ];
          keyword = "linkedinformatter";
          url = "https://www.linkedin-makeover.com/linkedin-text-formatter/";

}
{
   name = "Directions to Format Your LinkedIn Profile with Symbols / Bullets";
          tags = [ "linkedin", "tips", "symbols" ];
          keyword = "linkedinsymbols";
          url = "https://www.linkedin-makeover.com/tools/symbols/";

}
{
   name = "UTWS3 - Manual";
          tags = [ "audio", "manual", "headphones" ];
          keyword = "utws3manual";
          url = "http://fiio-instruction.fiio.net/UTWS3/UTWS3%20Quick_Start_Guide.pdf";

}
{
   name = "How to Get Users and Grow - Alex Schultz - CS183F - YouTube";
          tags = [ "marketing", "growth", "youtube" ];
          keyword = "getusersgrow";
          url = "https://www.youtube.com/watch?v=URiIsrdplbo";

}
{
   name = "Anna’s Archive";
          tags = [ "books", "archive", "resources" ];
          keyword = "annasarchive";
          url = "https://annas-archive.org/";

}
{
   name = "GNOME Shell Extensions";
          tags = [ "linux", "gnome", "extensions" ];
          keyword = "gnomeshellextensions";
          url = "https://extensions.gnome.org/";

}
{
   name = "R Tutorial for Beginners - Learn R Programming from Scratch - DataFlair";
          tags = [ "r", "tutorial", "beginners" ];
          keyword = "rtutorialbeginners";
          url = "https://data-flair.training/blogs/r-tutorials-home/";

}
{
   name = "Suchergebnisse";
          tags = [ "gardening", "seeds", "shop" ];
          keyword = "semillas";
          url = "https://www.semillas.de/cgi-bin/shop/shop.cgi";

}
{
   name = "Careers | Verbit AI transcriptions";
          tags = [ "jobs", "ai", "transcription" ];
          keyword = "verbitcareers";
          url = "https://verbit.ai/careers-listing/?vps=&career_location=Tel+Aviv%2C+Israel&career_position=";

}
{
   name = "31 Free Hi Res Audio Players [Windows Mac Linux Android iOS]";
          tags = [ "audio", "players", "hires" ];
          keyword = "hiresaudioplayers";
          url = "https://samplerateconverter.com/educational/audio-player";

}
{
   name = "Alerts - Open Trades | ClickCapital";
          tags = [ "finance", "trading", "alerts" ];
          keyword = "clickcapitalalerts";
          url = "https://www.clickcapital.io/alerts-open-trades";

}
{
   name = "טיפול במבוגרים עם הפרעת קשב וריכוז (ADHD) - קוג פאן";
          tags = [ "health", "adhd", "therapy" ];
          keyword = "adhdtherapy";
          url = "https://cogfun.co.il/%d7%98%d7%99%d7%a4%d7%95%d7%9c-%d7%91%d7%9e%d7%91%d7%95%d7%92%d7%a8%d7%99%d7%9d-%d7%a2%d7%9d-%d7%94%d7%a4%d7%a8%d7%a2%d7%aa-%d7%a7%d7%a9%d7%91-%d7%95%d7%a8%d7%99%d7%9b%d7%95%d7%96-adhd/";

}
{
   name = "teenage engineering - YouTube";
          tags = [ "music", "electronics", "youtube" ];
          keyword = "teenageengineering";
          url = "https://www.youtube.com/results?search_query=teenage+engineering";

}
{
   name = "(35) How to use Interactive Brokers Trader Workstation - TWS Strategy Lab - Option Trading Tutorial - YouTube";
          tags = [ "trading", "tws", "options", "youtube" ];
          keyword = "twsstrategylab";
          url = "https://www.youtube.com/watch?v=PxyTFgu53-g&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=78";

}
{
   name = "(40) How to Use Probability Lab to Set Up an Options Trading Strategy in Interactive Brokers - YouTube";
          tags = [ "trading", "options", "interactivebrokers", "youtube" ];
          keyword = "probabilitylab";
          url = "https://www.youtube.com/watch?v=3uttbB55STw&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=77";

}
{
   name = "How to Properly Use Margin with Interactive Brokers - YouTube";
          tags = [ "trading", "interactivebrokers", "margin", "youtube" ];
          keyword = "ibkrmargin";
          url = "https://www.youtube.com/watch?v=Y-MmaJKQHAk&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=84&t=15s";

}
{
   name = "(40) Connected Series on the Balance Beam featuring Coach Amanda Borden - YouTube";
          tags = [ "gymnastics", "youtube", "coaching" ];
          keyword = "balancebeam";
          url = "https://www.youtube.com/watch?v=qVHvrveZl2E";

}
{
   name = "(40) Financial Hacking and Optimization - YouTube";
          tags = [ "finance", "optimization", "youtube" ];
          keyword = "financialhacking";
          url = "https://www.youtube.com/playlist?list=PLePBf4ZtCKhp_spxhte1V729O91_SEXx5";

}
{
   name = "(35) IBKR Platform Videos - YouTube";
          tags = [ "trading", "interactivebrokers", "youtube" ];
          keyword = "ibkrplatformvideos";
          url = "https://www.youtube.com/playlist?list=PLePBf4ZtCKhqxQDPcHJ3zEFxrEowXTmrp";

}
{
   name = "(40) Interactive Brokers TWS Platform: How to trade directly from the Charts! - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twscharttrading";
          url = "https://www.youtube.com/watch?v=SGSxig40mgY&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=99&t=390s";

}
{
   name = "(40) TWS Trading Tutorial | Order Types, Presets & Routing - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twstutorial";
          url = "https://www.youtube.com/watch?v=AMCNNNlK8D0&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=100&t=146s";

}
{
   name = "(40) Interactive Brokers Platform Tutorial for Day Trading 2023 (Level II, Hotkeys, Indicators etc) - YouTube";
          tags = [ "trading", "interactivebrokers", "youtube" ];
          keyword = "ibkrdaytradingtutorial";
          url = "https://www.youtube.com/watch?v=UWTWz2GZq30&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=105&t=866s";

}
{
   name = "(35) Trader Workstation MOST IMPORTANT SETTINGS - YouTube";
          tags = [ "trading", "tws", "youtube" ];
          keyword = "twssettings";
          url = "https://www.youtube.com/watch?v=PeLgfvPFPv8&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=108";

}
{
   name = "(35) Become a Chart Patterns 'BEAST' | 3 Hours of 'Uninterrupted' Chart pattern course for beginners💯😎 - YouTube";
          tags = [ "trading", "chartpatterns", "youtube" ];
          keyword = "chartpatternsbeast";
          url = "https://www.youtube.com/watch?v=aVGrr2hMY5o&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=116&t=8s";

}
{
   name = "(34) Random video for you! #4 - YouTube";
          tags = [ "youtube", "random" ];
          keyword = "randomvideo";
          url = "https://www.youtube.com/watch?v=DlW8709Rc_0";

}
{
   name = "(34) YouTube";
          tags = [ "youtube", "history" ];
          keyword = "youtubehistory";
          url = "https://www.youtube.com/feed/history";

}
{
   name = "Interactive: Compare 250+ Impact Wrenches, 1000+ Tools - YouTube";
          tags = [ "tools", "comparison", "youtube" ];
          keyword = "impactwrenches";
          url = "https://www.youtube.com/watch?v=w7hKQ1SeNrk";

}
{
   name = "(35) Not Just Fake but Counterfeit Power Tools - YouTube";
          tags = [ "tools", "counterfeit", "youtube" ];
          keyword = "counterfeittools";
          url = "https://www.youtube.com/watch?v=3oBiFDr4bRU";

}
{
   name = "(35) Buying \"5000\" Lumen Flashlights | New Olight, AceBeam & More - YouTube";
          tags = [ "flashlights", "reviews", "youtube" ];
          keyword = "lumenflashlights";
          url = "https://www.youtube.com/watch?v=EBPQKeeYTfo";

}
{
   name = "(35) How Amazon Made the 1 Million Lumen Flashlight - YouTube";
          tags = [ "amazon", "flashlights", "youtube" ];
          keyword = "amazonflashlight";
          url = "https://www.youtube.com/watch?v=ceA5xL6ggEw";

}
{
   name = "(35) How to setup Interactive Brokers Market Data - Stock and Option Realtime Data - YouTube";
          tags = [ "trading", "interactivebrokers", "marketdata", "youtube" ];
          keyword = "ibkrmarketdata";
          url = "https://www.youtube.com/watch?v=pb9k4X5Jc-k";

}
{
   name = "(35) Which Market Data Subscription do I Need? (Futures, Stocks, Options) - YouTube";
          tags = [ "trading", "marketdata", "youtube" ];
          keyword = "marketdatasubscription";
          url = "https://www.youtube.com/watch?v=poBQVfdsxt8";

}
{
   name = "(35) Easiest Way To Set Up Market Data Subscriptions In Interactive Brokers - YouTube";
          tags = [ "trading", "interactivebrokers", "marketdata", "youtube" ];
          keyword = "ibkrmarketdatasubscriptions";
          url = "https://www.youtube.com/watch?v=hsNQLuOiLo8";

}
{
   name = "(35) Interactive Brokers TWS API + TradingView Charts Python Tutorial (Updated) - YouTube";
          tags = [ "trading", "twsapi", "tradingview", "python", "youtube" ];
          keyword = "ibkrtwsapipython";
          url = "https://www.youtube.com/watch?v=ZEtsLuXdC-g";

}
{
   name = "(35) Best IBKR TWS Scanner Settings for Day Trading - YouTube";
          tags = [ "trading", "tws", "scanner", "youtube" ];
          keyword = "ibkrtwsscanner";
          url = "https://www.youtube.com/watch?v=MevAc8brVOs";

}
{
   name = "(35) How to get LIVE Interactive Brokers Market Data Subscription (NO Delayed Market Data) - YouTube";
          tags = [ "trading", "interactivebrokers", "marketdata", "youtube" ];
          keyword = "ibkrlivemarketdata";
          url = "https://www.youtube.com/watch?v=r9SF_81fHrc";

}
{
   name = "TWS Setup for Day Trading Options & Stocks - Interactive Brokers - YouTube";
          tags = [ "trading", "tws", "options", "stocks", "youtube" ];
          keyword = "twsdaytradingsetup";
          url = "https://www.youtube.com/watch?v=C2E9yyi0l2s";

}
{
   name = "(35) I hated the TWS SCAN until I found these settings - Interactive Brokers - YouTube";
          tags = [ "trading", "tws", "scanner", "youtube" ];
          keyword = "twsscannerhacks";
          url = "https://www.youtube.com/watch?v=Y6NH7WydXyk";

}
{
   name = "(35) Best Day Trading Computer Setup - 2K VS 4K Trading Monitors? - YouTube";
          tags = [ "trading", "setup", "monitors", "youtube" ];
          keyword = "daytradingcomputers";
          url = "https://www.youtube.com/watch?v=jgRL3IRVaso";

}
{
   name = "(35) Best TWS Options Trading Layout for Interactive Brokers (Charts & Options Chain Platform Tutorial) - YouTube";
          tags = [ "trading", "tws", "options", "youtube" ];
          keyword = "twsoptionslayout";
          url = "https://www.youtube.com/watch?v=lcLFdmJtGEk";

}
{
   name = "(35) TradingView SECRET Settings That You Need to Know! - YouTube";
          tags = [ "tradingview", "settings", "youtube" ];
          keyword = "tradingviewsecrets";
          url = "https://www.youtube.com/watch?v=RhZQd4VM6JA";

}
{
   name = "(35) The 3 Most EPIC TradingView Settings You Need! - YouTube";
          tags = [ "tradingview", "settings", "youtube" ];
          keyword = "epictradingviewsettings";
          url = "https://www.youtube.com/watch?v=6XNiC8uohes";

}
{
   name = "(35) How to Convert Currency & Commissions Structure (Interactive Brokers) - YouTube";
          tags = [ "trading", "interactivebrokers", "currency", "commissions", "youtube" ];
          keyword = "ibkrcurrencycommissions";
          url = "https://www.youtube.com/watch?v=LHne1L68TJc";

}
{
   name = "(35) FULL Interactive Brokers TWS Tutorial For Beginners - (Chart, Level II, Hotkeys, Options, Settings) - YouTube";
          tags = [ "trading", "tws", "tutorial", "youtube" ];
          keyword = "fulltwstutorial";
          url = "https://www.youtube.com/watch?v=O_hWFar_aHE";

}
{
   name = "(35) Step-by-Step ULTIMATE TradingView Tutorial 2024 - YouTube";
          tags = [ "tradingview", "tutorial", "youtube" ];
          keyword = "ultimatetradingview";
          url = "https://www.youtube.com/watch?v=dqCSdF3KuPc";

}
{
   name = "Best TradingView Indicators 2024";
          tags = [ "tradingview", "indicators", "best" ];
          keyword = "besttradingviewindicators";
          url = "https://www.clickcapital.io/tradingview-indicators";

}
{
   name = "EMCS - Xtrackers MSCI Emerging Markets Climate Selection ETF Stock Price and Quote";
          tags = [ "finance", "etf", "stocks" ];
          keyword = "emcs";
          url = "https://finviz.com/quote.ashx?t=EMCS&p=d";

}
{
   name = "Meta Careers | Do the Most Meaningful Work of Your Career | Meta Careers";
          tags = [ "jobs", "meta", "careers" ];
          keyword = "metacareers";
          url = "https://www.metacareers.com/";

}
{
   name = "Add-ons Manager";
          tags = [ "firefox", "addons" ];
          keyword = "firefoxaddons";
          url = "about:addons";

}
{
   name = "Inbox (36) - laurentf84@gmail.com - Gmail";
          tags = [ "gmail", "email" ];
          keyword = "gmailinbox";
          url = "https://mail.google.com/mail/


  };
}