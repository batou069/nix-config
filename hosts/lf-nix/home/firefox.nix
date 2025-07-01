{
  pkgs,
  inputs,
  username,
  ...
}
: {
  programs.firefox = {
    enable = true;
    languagePacks = ["en-US" "de" "fr"];
    profiles = {
      personal = {
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          ublock-origin
          privacy-badger
          ghostery
          sponsorblock
          bitwarden
          pushbullet
          tab-session-manager
          stylus
          web-clipper-obsidian
          catppuccin-web-file-icons
          catppuccin-mocha-mauve
        ];
        settings = {
          "browser.startup.homepage" = "https://nixos.org";
        };
      };
      bookmarks = [
        {
          "name" = "Bookmarks";
          "bookmarks" = [
            {
              "name" = "Nutrition Seminars and Workshops";
              "url" = "https://lesliebeck.com/nutrition-services/nutrition-seminars-and-workshops";
            }
            {
              "name" = "10 Writing Ideas Concerning Women";
              "url" = "https://www.thoughtco.com/writing-ideas-concerning-women-31733";
            }
            {
              "name" = "Body, Mind, and Spirit | The Pioneer Woman";
              "url" = "https://thepioneerwoman.com/confessions/body-mind-and-spirit/";
            }
            {
              "name" = "5 Rules For The Spiritually Empowered Woman";
              "url" = "https://www.mindbodygreen.com/0-7694/5-rules-for-the-spiritually-empowered-woman.html";
            }
            {
              "name" = "Balancing Body, Mind and Spirit | Women's Radio Network";
              "url" = "http://www.womensradio.com/2019/05/balancing-body-mind-and-spirit/";
            }
            {
              "name" = "What happens to a woman’s body when she's raising kids, working, and trying to have it all - Business Insider";
              "url" = "https://www.businessinsider.com/nisha-jackson-womans-body-when-shes-raising-kids-working-have-it-all-2019-4";
            }
            {
              "name" = "Weight Training for Women = The Ultimate Strength Training Plan";
              "url" = "https://www.womenshealthmag.com/health/a19921596/weight-lifting-training-program/";
            }
            {
              "name" = "Women's Empowerment Seminar";
              "url" = "https://www.kravmaga.com/saam_2019/";
            }
            {
              "name" = "Seminars • MennoHenselmans.com";
              "url" = "https://mennohenselmans.com/seminar/";
            }
            {
              "name" = "Composerize";
              "url" = "https://www.composerize.com/";
            }
          ];
        }
        {
          "name" = "Bookmarks Toolbar";
          "toolbar" = true;
          "bookmarks" = [
            {
              "name" = "AI";
              "bookmarks" = [
                {
                  "name" = "OpenAI tokenizer";
                  "url" = "https://platform.openai.com/tokenizer";
                }
                {
                  "name" = "Gemini";
                  "url" = "https://gemini.google.com/app/250fbd46aa83c4cc";
                }
                {
                  "name" = "Perplexity";
                  "url" = "https://www.perplexity.ai/";
                }
                {
                  "name" = "Chat Playground - OpenAI API";
                  "url" = "https://platform.openai.com/playground/chat?models=gpt-4o";
                }
                {
                  "name" = "Facebook";
                  "url" = "https://www.facebook.com/ilja.sichrovsky";
                }
                {
                  "name" = "YoutubeBuddy · Streamlit";
                  "url" = "https://youtubebuddy.streamlit.app/";
                }
                {
                  "name" = "Complete List of Prompts & Styles for Suno AI Music (2024) | by Travis Nicholson | Medium";
                  "url" = "https://travisnicholson.medium.com/complete-list-of-prompts-styles-for-suno-ai-music-2024-33ecee85f180";
                }
                {
                  "name" = "Untitled prompt | Google AI Studio";
                  "url" = "https://aistudio.google.com/prompts/new_chat";
                }
              ];
            }
            {
              "name" = "$$$";
              "bookmarks" = [
                {
                  "name" = "Trading";
                  "bookmarks" = [
                    {
                      "name" = "IBI Trade (US)";
                      "url" = "https://ibi.viewtrade.com/";
                    }
                    {
                      "name" = "IBI Spark (IL)";
                      "url" = "https://sparkibi.ordernet.co.il/#/auth";
                    }
                    {
                      "name" = "Tradovate - Platform Knowledge Videos";
                      "url" = "https://www.tradovate.com/videos/?utm_term=demo&utm_campaign=Demo%20to%20Customer%202019&utm_medium=Email&_hsmi=103430268&utm_content=Demo%20to%20Customer%20%233%20%E2%80%94%20Features&utm_source=email";
                    }
                    {
                      "name" = "NextGen IBI";
                      "url" = "https://ibi.orbisfn.io/login";
                    }
                    {
                      "name" = "Tiger Brokers _ Hong Kong / U.S. Stock Market Quotes";
                      "url" = "https://www.itiger.com/sg";
                    }
                    {
                      "name" = "Interactive Brokers";
                      "url" = "https://www.interactivebrokers.com/";
                    }
                    {
                      "name" = "Swing Alerts | ClickCapital";
                      "url" = "https://www.clickcapital.io/alerts-open-trades";
                    }
                    {
                      "name" = "Stock Picks | ClickCapital";
                      "url" = "https://www.clickcapital.io/stock-picks-members";
                    }
                  ];
                }
                {
                  "name" = "Tools";
                  "bookmarks" = [
                    {
                      "name" = "Yahoo Finance - Stock Market Live, Quotes, Business & Finance News";
                      "url" = "https://finance.yahoo.com/";
                    }
                    {
                      "name" = "ETF Screener | etf.com";
                      "url" = "https://www.etf.com/etfanalytics/etf-screener";
                    }
                    {
                      "name" = "ETF Tools - stockanalysis.com";
                      "url" = "https://stockanalysis.com/etf/screener/";
                    }
                    {
                      "name" = "ETF Research Center";
                      "url" = "https://www.etfrc.com/index.php";
                    }
                    {
                      "name" = "ETF Database = The Original & Comprehensive Guide to ETFs";
                      "url" = "https://etfdb.com/";
                    }
                    {
                      "name" = "SweepCast | Unusual Options Activity for Retail Traders - Follow Smart Money";
                      "url" = "https://www.sweepcast.com/";
                    }
                  ];
                }
                {
                  "name" = "Knowledge";
                  "bookmarks" = [
                    {
                      "name" = "PineScript";
                      "bookmarks" = [
                        {
                          "name" = "Pine Script™ v5 User Manual";
                          "url" = "https://www.tradingview.com/pine-script-docs/en/v5/Introduction.html";
                        }
                      ];
                    }
                    {
                      "name" = "Options";
                      "bookmarks" = [
                        {
                          "name" = "Free Options Trading Courses | Option Alpha";
                          "url" = "https://optionalpha.com/courses";
                        }
                        {
                          "name" = "Learn to Trade & Invest = Insights, Resources";
                          "url" = "https://tastytrade.com/learn/";
                        }
                        {
                          "name" = "Introduction to Options - CME Group";
                          "url" = "https://www.cmegroup.com/education/courses/introduction-to-options.html";
                        }
                        {
                          "name" = "Option Strategies - CME Group";
                          "url" = "https://www.cmegroup.com/education/courses/option-strategies.html";
                        }
                        {
                          "name" = "Tools for Option Analysis - CME Group";
                          "url" = "https://www.cmegroup.com/education/courses/tools-for-option-analysis.html";
                        }
                      ];
                    }
                    {
                      "name" = "Bloomberg for Education";
                      "url" = "https://portal.bloombergforeducation.com/";
                    }
                    {
                      "name" = "Fixed Income";
                      "bookmarks" = [
                        {
                          "name" = "The Basics of Treasuries Basis - CME Group";
                          "url" = "https://www.cmegroup.com/education/courses/introduction-to-treasuries/the-basics-of-treasuries-basis.html";
                        }
                      ];
                    }
                    {
                      "name" = "Analysis";
                      "bookmarks" = [
                        {
                          "name" = "Technical Analysis - CME Group";
                          "url" = "https://www.cmegroup.com/education/courses/technical-analysis.html";
                        }
                        {
                          "name" = "Trading and Analysis - CME Group";
                          "url" = "https://www.cmegroup.com/education/courses/trading-and-analysis.html";
                        }
                      ];
                    }
                    {
                      "name" = "Learn about Key Economic Events - CME Group";
                      "url" = "https://www.cmegroup.com/education/courses/learn-about-key-economic-events.html";
                    }
                    {
                      "name" = "Trade and Risk Management - CME Group";
                      "url" = "https://www.cmegroup.com/education/courses/trade-and-risk-management.html";
                    }
                    {
                      "name" = "Introduction to Equity Index Products - CME Group";
                      "url" = "https://www.cmegroup.com/education/courses/introduction-to-equity-index-products.html";
                    }
                    {
                      "name" = "Futures vs. ETFs - CME Group";
                      "url" = "https://www.cmegroup.com/education/courses/futures-vs-etfs.html";
                    }
                    {
                      "name" = "Reddit";
                      "bookmarks" = [
                        {
                          "name" = "Reddit - Dive into anything";
                          "url" = "https://www.reddit.com/r/RealDayTrading/wiki/index/";
                        }
                        {
                          "name" = "r/RealDayTrading";
                          "bookmarks" = [
                            {
                              "name" = "(5) Adding a Sector List and the Top 10 for each sector to a Trading View watchlist  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/18ap05y/adding_a_sector_list_and_the_top_10_for_each/";
                            }
                            {
                              "name" = "Sign in to TC2000®";
                              "url" = "https://www.tc2000.com/sign-in?webplatform=true&returnURL=https://webplatform.tc2000.com/RASHTML5Gateway/";
                            }
                            {
                              "name" = "(5) Sector scanner for Trading View  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/x8v8cd/sector_scanner_for_trading_view/";
                            }
                            {
                              "name" = "> Sector Relative Strength — Indicator by atlas54000 — TradingView";
                              "url" = "https://www.tradingview.com/script/fcSCAIv5-Sector-Relative-Strength/";
                            }
                            {
                              "name" = "(5) I \"Shorted Stupid\" and I Got Burned!  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/y24905/i_shorted_stupid_and_i_got_burned/";
                            }
                            {
                              "name" = "> (5) Bearish Trend Days. How To Spot Them and How To Trade Them  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/xy8756/bearish_trend_days_how_to_spot_them_and_how_to/";
                            }
                            {
                              "name" = ">> (10) Bearish Trend Days - How To Trade Them - YouTube";
                              "url" = "https://www.youtube.com/watch?v=kPfWxS12yUY";
                            }
                            {
                              "name" = "> (10) Why This Gap and Go Pattern Failed - YouTube";
                              "url" = "https://www.youtube.com/watch?v=FmhUYeGCGgU";
                            }
                            {
                              "name" = "(4) Simple RS Strategy using trendline (Great for newbies)  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/ty0tjw/simple_rs_strategy_using_trendline_great_for/";
                            }
                            {
                              "name" = "(5) A Tool For Compiling Your Market Rebound Picks  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/v5kjav/a_tool_for_compiling_your_market_rebound_picks/";
                            }
                            {
                              "name" = "(5) Analyzed 450 Trades - This might be helpful  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/t7li41/analyzed_450_trades_this_might_be_helpful/";
                            }
                            {
                              "name" = "(5) Need help with identifying institutional support.  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/16zzjun/need_help_with_identifying_institutional_support/";
                            }
                            {
                              "name" = "(5) Update to relative strength stock and sector script post  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/weuik4/update_to_relative_strength_stock_and_sector/";
                            }
                            {
                              "name" = "(5) Real Relative Strength to SECTOR Indicator + Auto Sector Selection [TOS/TV]  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/x9dwv0/real_relative_strength_to_sector_indicator_auto/";
                            }
                            {
                              "name" = "(5) Strong sector or strong stock?  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/10n9i59/strong_sector_or_strong_stock/";
                            }
                            {
                              "name" = "(5) Sector / Industry Strength Comparison on Tradingview  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/tiprot/sector_industry_strength_comparison_on_tradingview/";
                            }
                            {
                              "name" = "(5) (Expanded to *Most* Stocks) Real Relative Strength to SECTOR Indicator + Auto Sector Selection [TOS]  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/z02d6b/expanded_to_most_stocks_real_relative_strength_to/";
                            }
                            {
                              "name" = "(5) Stacked Stock/Sector/Market RS/RW Arrows for TradingView  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/z9u03i/stacked_stocksectormarket_rsrw_arrows_for/";
                            }
                            {
                              "name" = "(5) Question About Sector Performance  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/170uagf/question_about_sector_performance/";
                            }
                            {
                              "name" = "(5) Relative Strength to stock and sector indicator for TOS  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/wb3x7c/relative_strength_to_stock_and_sector_indicator/";
                            }
                            {
                              "name" = "(5) Sector / Industry Strength Comparison on Tradingview  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/tiprot/sector_industry_strength_comparison_on_tradingview/";
                            }
                            {
                              "name" = "(5) I \"Shorted Stupid\" and I Got Burned!  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/y24905/i_shorted_stupid_and_i_got_burned/";
                            }
                            {
                              "name" = "(5) A very handy way to pull financial data  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/11widn4/a_very_handy_way_to_pull_financial_data/";
                            }
                            {
                              "name" = "> Download | OpenBB Terminal";
                              "url" = "https://my.openbb.co/app/terminal/download";
                            }
                            {
                              "name" = "Real Relative Strength to SECTOR Indicator + Auto Sector Selection [TOS/TV]  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/x9dwv0/real_relative_strength_to_sector_indicator_auto/";
                            }
                          ];
                        }
                      ];
                    }
                    {
                      "name" = "Tools";
                      "bookmarks" = [
                        {
                          "name" = "OpenBB Terminal Docs";
                          "url" = "https://docs.openbb.co/terminal";
                        }
                        {
                          "name" = "Order Types and Algos | Interactive Brokers LLC";
                          "url" = "https://www.interactivebrokers.com/en/trading/ordertypes.php";
                        }
                        {
                          "name" = "Basic Economics | Trading Course | Traders' Academy | IBKR Campus";
                          "url" = "https://ibkrcampus.com/trading-course/introduction-to-microeconomics/?src=_X_MAILING_ID&eid=_X_EID&blst=NL-TI_cps_artclbtn";
                        }
                        {
                          "name" = "Getting Started with TWS | Trading Lesson | Traders' Academy | IBKR Campus";
                          "url" = "https://ibkrcampus.com/trading-lessons/getting-started-with-tws/";
                        }
                        {
                          "name" = "בית פרטי/ קוטג', פרדס חנה כרכור | אלפי מודעות חדשות בכל יום!";
                          "url" = "https://www.yad2.co.il/realestate/item/qi61ryus?ad-location=Main+feed+listings&opened-from=Feed+view&component-type=main_feed&index=19&color-type=Grey";
                        }
                        {
                          "name" = "(1) Veena Krishnamurthy | LinkedIn";
                          "url" = "https://www.linkedin.com/in/veena-krishnamurthy/";
                        }
                      ];
                    }
                    {
                      "name" = "GitHub - wilsonfreitas/awesome-quant = A curated list of insanely awesome libraries, packages and resources for Quants (Quantitative Finance)";
                      "url" = "https://github.com/wilsonfreitas/awesome-quant";
                    }
                    {
                      "name" = "OCC - Investor Education";
                      "url" = "https://www.theocc.com/company-information/investor-education";
                    }
                  ];
                }
                {
                  "name" = "Platforms";
                  "bookmarks" = [
                    {
                      "name" = "koyfin";
                      "url" = "https://app.koyfin.com/home";
                    }
                  ];
                }
                {
                  "name" = "Research";
                  "bookmarks" = [
                    {
                      "name" = "Sectors";
                      "bookmarks" = [
                        {
                          "name" = "Select Sector SPDR ETFs - Sector Spiders ETFs | SPDR S&P Stock";
                          "url" = "https://www.sectorspdrs.com/";
                        }
                      ];
                    }
                  ];
                }
                {
                  "name" = "Investopedia Stock Simulator";
                  "url" = "https://www.investopedia.com/simulator/portfolio";
                }
                {
                  "name" = "מדריכים וכלים של פעמונים - paamonim";
                  "url" = "https://www.paamonim.org/he/%D7%9B%D7%9C%D7%99%D7%9D-%D7%95%D7%9E%D7%97%D7%A9%D7%91%D7%95%D7%A0%D7%99%D7%9D/";
                }
                {
                  "name" = "TipRanks";
                  "url" = "https://www.tipranks.com/dashboard";
                }
                {
                  "name" = "(18) TWS Trading Tutorial | Order Types, Presets & Routing - YouTube and more (2024.03.10)";
                  "bookmarks" = [
                    {
                      "name" = "(18) TWS Trading Tutorial | Order Types, Presets & Routing - YouTube";
                      "url" = "https://www.youtube.com/watch?v=AMCNNNlK8D0&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=102&t=62s";
                    }
                    {
                      "name" = "> (18) How to use Adjustable Stop and Scale Target Orders in TWS - YouTube";
                      "url" = "https://www.youtube.com/watch?v=RYykmLiGbMU&t=493s";
                    }
                    {
                      "name" = "> (18) How to use a Bracket Order in TWS (Stop-loss/Take Profit) - YouTube";
                      "url" = "https://www.youtube.com/watch?v=b-x_cwH99C4&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=63";
                    }
                    {
                      "name" = "> (18) How to Properly Use Margin with Interactive Brokers - YouTube";
                      "url" = "https://www.youtube.com/watch?v=Y-MmaJKQHAk&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=85";
                    }
                    {
                      "name" = "> (18) Interactive Brokers TWS Platform = How to trade directly from the Charts! - YouTube";
                      "url" = "https://www.youtube.com/watch?v=SGSxig40mgY&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=101&t=390s";
                    }
                    {
                      "name" = "> (18) How to FIX Your IBKR TWS Charts in 2 Minutes - YouTube";
                      "url" = "https://www.youtube.com/watch?v=hrO3KoXs5MU&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=100";
                    }
                    {
                      "name" = ">> (18) Step-by-Step TWS CHART Settings - (Interactive Brokers Tutorial) - YouTube";
                      "url" = "https://www.youtube.com/watch?v=F1d8r-MWjfM&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=111";
                    }
                    {
                      "name" = "> (18) 10 Tips & Tricks To Master Interactive Brokers - YouTube";
                      "url" = "https://www.youtube.com/watch?v=HR0S-0sgb7o&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=108";
                    }
                    {
                      "name" = ">> (18) Interactive Brokers Platform Tutorial for Day Trading 2023 (Level II, Hotkeys, Indicators etc) - YouTube";
                      "url" = "https://www.youtube.com/watch?v=UWTWz2GZq30&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=106&t=866s";
                    }
                    {
                      "name" = ">> (18) How to Set Up TWS layout/Interactive Brokers - YouTube";
                      "url" = "https://www.youtube.com/watch?v=mYVnhTe2ce0&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=74";
                    }
                  ];
                }
              ];
            }
          ];
        }
      ];
    };
    policies = {
      DisablePocket = true;
      DisableTelemetry = true;
      DownloadDirectory = "/home/${username}/Downloads";
      EnableTrackingProtection = true;
      HttpsOnlyMode = true;
      OfferToSaveLogins = false;
      OfferToSaveLoginsDefault = false;
      PasswordManagerEnabled = false;
      PDFjs = false;
      PictureInPicture = true;
      ShowHomeButton = false;
      PromptForDownloadLocation = false;
      DisableProfileImport = false;
      DisableFirefoxStudies = true;
      DisableFeedbackCommands = true;
      DisableDeveloperTools = false;
      DisableBuiltinPDFViewer = true;
      DisableAppUpdate = true;
      DefaultDownloadDirectory = "/home/${username}/Downloads";
    };
  };
}
