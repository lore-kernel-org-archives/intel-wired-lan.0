From: Kevin Newman <knewman@peak6.com>
Date: Mon, 6 Apr 2020 15:22:22 +0000
Subject: [Intel-wired-lan] X550 + ixgbe Reporting "ECC Err" With Strange
 Regularity...
Message-ID: <MWHPR2201MB1727D9040A0A395978363BB0E9C20@MWHPR2201MB1727.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I'm seeing a strangely high incidence of the following type of "ECC error" on X550 NICs running ixgbe 5.1.0 via kernel 4.15.0:

2020-04-06T08:35:16.077662-05:00 dell-server1 kernel: [155528.916479] ixgbe 0000:19:00.1 eno2: Received ECC Err, initiating reset
2020-04-06T08:35:16.077684-05:00 dell-server1 kernel: [155528.916480] ixgbe 0000:19:00.0 eno1: Received ECC Err, initiating reset
2020-04-06T08:35:16.077685-05:00 dell-server1 kernel: [155528.916491] ixgbe 0000:19:00.0 eno1: Reset adapter
2020-04-06T08:35:16.090422-05:00 dell-server1 kernel: [155528.930407] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 0 not cleared within the polling period
2020-04-06T08:35:16.090439-05:00 dell-server1 kernel: [155528.930572] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 1 not cleared within the polling period
2020-04-06T08:35:16.090440-05:00 dell-server1 kernel: [155528.930721] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 2 not cleared within the polling period
2020-04-06T08:35:16.090440-05:00 dell-server1 kernel: [155528.930877] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 3 not cleared within the polling period
2020-04-06T08:35:16.090442-05:00 dell-server1 kernel: [155528.931032] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 4 not cleared within the polling period
2020-04-06T08:35:16.090443-05:00 dell-server1 kernel: [155528.931188] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 5 not cleared within the polling period
2020-04-06T08:35:16.094301-05:00 dell-server1 kernel: [155528.933193] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 6 not cleared within the polling period
2020-04-06T08:35:16.094319-05:00 dell-server1 kernel: [155528.935148] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 7 not cleared within the polling period
2020-04-06T08:35:16.098055-05:00 dell-server1 kernel: [155528.937064] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 8 not cleared within the polling period
2020-04-06T08:35:16.098062-05:00 dell-server1 kernel: [155528.938939] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 9 not cleared within the polling period
2020-04-06T08:35:16.101678-05:00 dell-server1 kernel: [155528.940816] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 10 not cleared within the polling period
2020-04-06T08:35:16.101685-05:00 dell-server1 kernel: [155528.942620] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 11 not cleared within the polling period
2020-04-06T08:35:16.106751-05:00 dell-server1 kernel: [155528.944435] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 12 not cleared within the polling period
2020-04-06T08:35:16.106759-05:00 dell-server1 kernel: [155528.946149] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 13 not cleared within the polling period
2020-04-06T08:35:16.106760-05:00 dell-server1 kernel: [155528.947827] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 14 not cleared within the polling period
2020-04-06T08:35:16.109948-05:00 dell-server1 kernel: [155528.949507] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 15 not cleared within the polling period
2020-04-06T08:35:16.109955-05:00 dell-server1 kernel: [155528.951112] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 16 not cleared within the polling period
2020-04-06T08:35:16.114513-05:00 dell-server1 kernel: [155528.952707] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 17 not cleared within the polling period
2020-04-06T08:35:16.114522-05:00 dell-server1 kernel: [155528.954248] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 18 not cleared within the polling period
2020-04-06T08:35:16.114528-05:00 dell-server1 kernel: [155528.955757] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 19 not cleared within the polling period
2020-04-06T08:35:16.118763-05:00 dell-server1 kernel: [155528.957271] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 20 not cleared within the polling period
2020-04-06T08:35:16.118769-05:00 dell-server1 kernel: [155528.958751] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 21 not cleared within the polling period
2020-04-06T08:35:16.118770-05:00 dell-server1 kernel: [155528.960153] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 22 not cleared within the polling period
2020-04-06T08:35:16.122679-05:00 dell-server1 kernel: [155528.961525] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 23 not cleared within the polling period
2020-04-06T08:35:16.122690-05:00 dell-server1 kernel: [155528.962851] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 24 not cleared within the polling period
2020-04-06T08:35:16.122691-05:00 dell-server1 kernel: [155528.964160] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 25 not cleared within the polling period
2020-04-06T08:35:16.126155-05:00 dell-server1 kernel: [155528.965440] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 26 not cleared within the polling period
2020-04-06T08:35:16.126167-05:00 dell-server1 kernel: [155528.966637] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 27 not cleared within the polling period
2020-04-06T08:35:16.126168-05:00 dell-server1 kernel: [155528.967767] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 28 not cleared within the polling period
2020-04-06T08:35:16.130187-05:00 dell-server1 kernel: [155528.968913] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 29 not cleared within the polling period
2020-04-06T08:35:16.130206-05:00 dell-server1 kernel: [155528.969974] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 30 not cleared within the polling period
2020-04-06T08:35:16.130207-05:00 dell-server1 kernel: [155528.971011] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 31 not cleared within the polling period
2020-04-06T08:35:16.130208-05:00 dell-server1 kernel: [155528.971998] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 32 not cleared within the polling period
2020-04-06T08:35:16.134180-05:00 dell-server1 kernel: [155528.972946] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 33 not cleared within the polling period
2020-04-06T08:35:16.134192-05:00 dell-server1 kernel: [155528.973828] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 34 not cleared within the polling period
2020-04-06T08:35:16.134193-05:00 dell-server1 kernel: [155528.974679] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 35 not cleared within the polling period
2020-04-06T08:35:16.134194-05:00 dell-server1 kernel: [155528.975470] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 36 not cleared within the polling period
2020-04-06T08:35:16.134195-05:00 dell-server1 kernel: [155528.976227] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 37 not cleared within the polling period
2020-04-06T08:35:16.137630-05:00 dell-server1 kernel: [155528.976933] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 38 not cleared within the polling period
2020-04-06T08:35:16.137641-05:00 dell-server1 kernel: [155528.977592] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 39 not cleared within the polling period
2020-04-06T08:35:16.137642-05:00 dell-server1 kernel: [155528.978215] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 40 not cleared within the polling period
2020-04-06T08:35:16.137643-05:00 dell-server1 kernel: [155528.978796] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 41 not cleared within the polling period
2020-04-06T08:35:16.137644-05:00 dell-server1 kernel: [155528.979335] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 42 not cleared within the polling period
2020-04-06T08:35:16.137645-05:00 dell-server1 kernel: [155528.979830] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 43 not cleared within the polling period
2020-04-06T08:35:16.141629-05:00 dell-server1 kernel: [155528.980314] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 44 not cleared within the polling period
2020-04-06T08:35:16.141640-05:00 dell-server1 kernel: [155528.980712] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 45 not cleared within the polling period
2020-04-06T08:35:16.141641-05:00 dell-server1 kernel: [155528.981079] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 46 not cleared within the polling period
2020-04-06T08:35:16.141642-05:00 dell-server1 kernel: [155528.981433] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 47 not cleared within the polling period
2020-04-06T08:35:16.141649-05:00 dell-server1 kernel: [155528.981761] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 48 not cleared within the polling period
2020-04-06T08:35:16.141650-05:00 dell-server1 kernel: [155528.982083] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 49 not cleared within the polling period
2020-04-06T08:35:16.141651-05:00 dell-server1 kernel: [155528.982414] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 50 not cleared within the polling period
2020-04-06T08:35:16.141652-05:00 dell-server1 kernel: [155528.982735] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 51 not cleared within the polling period
2020-04-06T08:35:16.141652-05:00 dell-server1 kernel: [155528.983061] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 52 not cleared within the polling period
2020-04-06T08:35:16.141722-05:00 dell-server1 kernel: [155528.983390] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 53 not cleared within the polling period
2020-04-06T08:35:16.141738-05:00 dell-server1 kernel: [155528.983703] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 54 not cleared within the polling period
2020-04-06T08:35:16.141740-05:00 dell-server1 kernel: [155528.984032] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 55 not cleared within the polling period
2020-04-06T08:35:16.141748-05:00 dell-server1 kernel: [155528.984375] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 56 not cleared within the polling period
2020-04-06T08:35:16.145642-05:00 dell-server1 kernel: [155528.984697] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 57 not cleared within the polling period
2020-04-06T08:35:16.145653-05:00 dell-server1 kernel: [155528.985012] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 58 not cleared within the polling period
2020-04-06T08:35:16.145654-05:00 dell-server1 kernel: [155528.985316] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 59 not cleared within the polling period
2020-04-06T08:35:16.145655-05:00 dell-server1 kernel: [155528.985624] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 60 not cleared within the polling period
2020-04-06T08:35:16.145690-05:00 dell-server1 kernel: [155528.985936] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 61 not cleared within the polling period
2020-04-06T08:35:16.145691-05:00 dell-server1 kernel: [155528.986246] ixgbe 0000:19:00.0 eno1: RXDCTL.ENABLE on Rx queue 62 not cleared within the polling period
2020-04-06T08:35:17.037635-05:00 dell-server1 kernel: [155529.877028] ixgbe 0000:19:00.1 eno2: Reset adapter
2020-04-06T08:35:17.037648-05:00 dell-server1 kernel: [155529.877044] ixgbe 0000:19:00.0 eno1: speed changed to 0 for port eno1
2020-04-06T08:35:17.049728-05:00 dell-server1 kernel: [155529.891566] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 0 not cleared within the polling period
2020-04-06T08:35:17.049734-05:00 dell-server1 kernel: [155529.891856] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 1 not cleared within the polling period
2020-04-06T08:35:17.049736-05:00 dell-server1 kernel: [155529.892133] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 2 not cleared within the polling period
2020-04-06T08:35:17.053617-05:00 dell-server1 kernel: [155529.892410] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 3 not cleared within the polling period
2020-04-06T08:35:17.053621-05:00 dell-server1 kernel: [155529.892665] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 4 not cleared within the polling period
2020-04-06T08:35:17.053621-05:00 dell-server1 kernel: [155529.892917] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 5 not cleared within the polling period
2020-04-06T08:35:17.053622-05:00 dell-server1 kernel: [155529.893170] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 6 not cleared within the polling period
2020-04-06T08:35:17.053622-05:00 dell-server1 kernel: [155529.893420] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 7 not cleared within the polling period
2020-04-06T08:35:17.053623-05:00 dell-server1 kernel: [155529.893670] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 8 not cleared within the polling period
2020-04-06T08:35:17.053625-05:00 dell-server1 kernel: [155529.893921] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 9 not cleared within the polling period
2020-04-06T08:35:17.053626-05:00 dell-server1 kernel: [155529.894171] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 10 not cleared within the polling period
2020-04-06T08:35:17.053626-05:00 dell-server1 kernel: [155529.894430] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 11 not cleared within the polling period
2020-04-06T08:35:17.053627-05:00 dell-server1 kernel: [155529.894688] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 12 not cleared within the polling period
2020-04-06T08:35:17.053628-05:00 dell-server1 kernel: [155529.894945] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 13 not cleared within the polling period
2020-04-06T08:35:17.053629-05:00 dell-server1 kernel: [155529.895201] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 14 not cleared within the polling period
2020-04-06T08:35:17.053630-05:00 dell-server1 kernel: [155529.895458] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 15 not cleared within the polling period
2020-04-06T08:35:17.053630-05:00 dell-server1 kernel: [155529.895715] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 16 not cleared within the polling period
2020-04-06T08:35:17.053700-05:00 dell-server1 kernel: [155529.895971] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 17 not cleared within the polling period
2020-04-06T08:35:17.053722-05:00 dell-server1 kernel: [155529.896235] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 18 not cleared within the polling period
2020-04-06T08:35:17.057692-05:00 dell-server1 kernel: [155529.896519] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 19 not cleared within the polling period
2020-04-06T08:35:17.057697-05:00 dell-server1 kernel: [155529.896775] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 20 not cleared within the polling period
2020-04-06T08:35:17.057698-05:00 dell-server1 kernel: [155529.897029] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 21 not cleared within the polling period
2020-04-06T08:35:17.057699-05:00 dell-server1 kernel: [155529.897285] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 22 not cleared within the polling period
2020-04-06T08:35:17.057699-05:00 dell-server1 kernel: [155529.897540] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 23 not cleared within the polling period
2020-04-06T08:35:17.057700-05:00 dell-server1 kernel: [155529.897796] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 24 not cleared within the polling period
2020-04-06T08:35:17.057701-05:00 dell-server1 kernel: [155529.898049] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 25 not cleared within the polling period
2020-04-06T08:35:17.057705-05:00 dell-server1 kernel: [155529.898309] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 26 not cleared within the polling period
2020-04-06T08:35:17.057706-05:00 dell-server1 kernel: [155529.898562] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 27 not cleared within the polling period
2020-04-06T08:35:17.057708-05:00 dell-server1 kernel: [155529.898815] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 28 not cleared within the polling period
2020-04-06T08:35:17.057710-05:00 dell-server1 kernel: [155529.899069] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 29 not cleared within the polling period
2020-04-06T08:35:17.057711-05:00 dell-server1 kernel: [155529.899322] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 30 not cleared within the polling period
2020-04-06T08:35:17.057713-05:00 dell-server1 kernel: [155529.899575] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 31 not cleared within the polling period
2020-04-06T08:35:17.057715-05:00 dell-server1 kernel: [155529.899828] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 32 not cleared within the polling period
2020-04-06T08:35:17.057716-05:00 dell-server1 kernel: [155529.900082] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 33 not cleared within the polling period
2020-04-06T08:35:17.061626-05:00 dell-server1 kernel: [155529.900350] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 34 not cleared within the polling period
2020-04-06T08:35:17.061632-05:00 dell-server1 kernel: [155529.900605] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 35 not cleared within the polling period
2020-04-06T08:35:17.061633-05:00 dell-server1 kernel: [155529.900859] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 36 not cleared within the polling period
2020-04-06T08:35:17.061633-05:00 dell-server1 kernel: [155529.901114] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 37 not cleared within the polling period
2020-04-06T08:35:17.061634-05:00 dell-server1 kernel: [155529.901368] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 38 not cleared within the polling period
2020-04-06T08:35:17.061635-05:00 dell-server1 kernel: [155529.901622] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 39 not cleared within the polling period
2020-04-06T08:35:17.061636-05:00 dell-server1 kernel: [155529.901876] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 40 not cleared within the polling period
2020-04-06T08:35:17.061637-05:00 dell-server1 kernel: [155529.902130] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 41 not cleared within the polling period
2020-04-06T08:35:17.061641-05:00 dell-server1 kernel: [155529.902383] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 42 not cleared within the polling period
2020-04-06T08:35:17.061642-05:00 dell-server1 kernel: [155529.902636] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 43 not cleared within the polling period
2020-04-06T08:35:17.061643-05:00 dell-server1 kernel: [155529.902890] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 44 not cleared within the polling period
2020-04-06T08:35:17.061643-05:00 dell-server1 kernel: [155529.903145] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 45 not cleared within the polling period
2020-04-06T08:35:17.061644-05:00 dell-server1 kernel: [155529.903383] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 46 not cleared within the polling period
2020-04-06T08:35:17.061656-05:00 dell-server1 kernel: [155529.903616] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 47 not cleared within the polling period
2020-04-06T08:35:17.061658-05:00 dell-server1 kernel: [155529.903836] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 48 not cleared within the polling period
2020-04-06T08:35:17.061659-05:00 dell-server1 kernel: [155529.904054] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 49 not cleared within the polling period
2020-04-06T08:35:17.065643-05:00 dell-server1 kernel: [155529.904286] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 50 not cleared within the polling period
2020-04-06T08:35:17.065655-05:00 dell-server1 kernel: [155529.904510] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 51 not cleared within the polling period
2020-04-06T08:35:17.065656-05:00 dell-server1 kernel: [155529.904730] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 52 not cleared within the polling period
2020-04-06T08:35:17.065661-05:00 dell-server1 kernel: [155529.904950] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 53 not cleared within the polling period
2020-04-06T08:35:17.065662-05:00 dell-server1 kernel: [155529.905170] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 54 not cleared within the polling period
2020-04-06T08:35:17.065670-05:00 dell-server1 kernel: [155529.905389] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 55 not cleared within the polling period
2020-04-06T08:35:17.065671-05:00 dell-server1 kernel: [155529.905608] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 56 not cleared within the polling period
2020-04-06T08:35:17.065672-05:00 dell-server1 kernel: [155529.905827] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 57 not cleared within the polling period
2020-04-06T08:35:17.065673-05:00 dell-server1 kernel: [155529.906039] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 58 not cleared within the polling period
2020-04-06T08:35:17.065674-05:00 dell-server1 kernel: [155529.906250] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 59 not cleared within the polling period
2020-04-06T08:35:17.065674-05:00 dell-server1 kernel: [155529.906462] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 60 not cleared within the polling period
2020-04-06T08:35:17.065675-05:00 dell-server1 kernel: [155529.906674] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 61 not cleared within the polling period
2020-04-06T08:35:17.065676-05:00 dell-server1 kernel: [155529.906885] ixgbe 0000:19:00.1 eno2: RXDCTL.ENABLE on Rx queue 62 not cleared within the polling period
2020-04-06T08:35:17.965630-05:00 dell-server1 kernel: [155530.804204] bond0: link status definitely down for interface eno1, disabling it
2020-04-06T08:35:17.965648-05:00 dell-server1 kernel: [155530.804272] bond0: link status definitely down for interface eno2, disabling it
2020-04-06T08:35:17.965649-05:00 dell-server1 kernel: [155530.804274] bond0: now running without any active interface!
2020-04-06T08:35:18.069645-05:00 dell-server1 kernel: [155530.908165] bond0: link status definitely down for interface eno2, disabling it
2020-04-06T08:35:22.137624-05:00 dell-server1 kernel: [155534.976629] ixgbe 0000:19:00.0 eno1: NIC Link is Up 10 Gbps, Flow Control: None
2020-04-06T08:35:22.141618-05:00 dell-server1 kernel: [155534.979784] bond0: link status definitely up for interface eno1, 10000 Mbps full duplex
2020-04-06T08:35:22.141627-05:00 dell-server1 kernel: [155534.979791] bond0: first active interface up!
2020-04-06T08:35:23.005627-05:00 dell-server1 kernel: [155535.844845] ixgbe 0000:19:00.1 eno2: NIC Link is Up 10 Gbps, Flow Control: None
2020-04-06T08:35:23.077611-05:00 dell-server1 kernel: [155535.915696] bond0: link status definitely up for interface eno2, 10000 Mbps full duplex
2020-04-06T08:35:25.256404-05:00 dell-server1 kernel: [155538.083623] ixgbe 0000:19:00.0 eno1: Detected Tx Unit Hang
2020-04-06T08:35:25.256418-05:00 dell-server1 kernel: [155538.083623]   Tx Queue             <39>
2020-04-06T08:35:25.256419-05:00 dell-server1 kernel: [155538.083623]   TDH, TDT             <0>, <d>
2020-04-06T08:35:25.256420-05:00 dell-server1 kernel: [155538.083623]   next_to_use          <d>
2020-04-06T08:35:25.256421-05:00 dell-server1 kernel: [155538.083623]   next_to_clean        <0>
2020-04-06T08:35:25.256421-05:00 dell-server1 kernel: [155538.083623] tx_buffer_info[next_to_clean]
2020-04-06T08:35:25.256422-05:00 dell-server1 kernel: [155538.083623]   time_stamp           <1025039c7>
2020-04-06T08:35:25.256422-05:00 dell-server1 kernel: [155538.083623]   jiffies              <102503cb8>
2020-04-06T08:35:25.256423-05:00 dell-server1 kernel: [155538.083626] ixgbe 0000:19:00.0 eno1: Detected Tx Unit Hang
2020-04-06T08:35:25.256424-05:00 dell-server1 kernel: [155538.083626]   Tx Queue             <35>
2020-04-06T08:35:25.256425-05:00 dell-server1 kernel: [155538.083626]   TDH, TDT             <0>, <6>
2020-04-06T08:35:25.256425-05:00 dell-server1 kernel: [155538.083626]   next_to_use          <6>
2020-04-06T08:35:25.256425-05:00 dell-server1 kernel: [155538.083626]   next_to_clean        <0>
2020-04-06T08:35:25.256439-05:00 dell-server1 kernel: [155538.083626] tx_buffer_info[next_to_clean]
2020-04-06T08:35:25.256440-05:00 dell-server1 kernel: [155538.083626]   time_stamp           <1025039e0>
2020-04-06T08:35:25.256441-05:00 dell-server1 kernel: [155538.083626]   jiffies              <102503cb8>
2020-04-06T08:35:25.256443-05:00 dell-server1 kernel: [155538.083629] ixgbe 0000:19:00.0 eno1: Detected Tx Unit Hang
2020-04-06T08:35:25.256444-05:00 dell-server1 kernel: [155538.083629]   Tx Queue             <52>
2020-04-06T08:35:25.256445-05:00 dell-server1 kernel: [155538.083629]   TDH, TDT             <0>, <3>
2020-04-06T08:35:25.256445-05:00 dell-server1 kernel: [155538.083629]   next_to_use          <3>
2020-04-06T08:35:25.256449-05:00 dell-server1 kernel: [155538.083629]   next_to_clean        <0>
2020-04-06T08:35:25.256450-05:00 dell-server1 kernel: [155538.083629] tx_buffer_info[next_to_clean]
2020-04-06T08:35:25.256451-05:00 dell-server1 kernel: [155538.083629]   time_stamp           <102503a08>
2020-04-06T08:35:25.256453-05:00 dell-server1 kernel: [155538.083629]   jiffies              <102503cb8>
2020-04-06T08:35:25.256454-05:00 dell-server1 kernel: [155538.083632] ixgbe 0000:19:00.0 eno1: Detected Tx Unit Hang
2020-04-06T08:35:25.256456-05:00 dell-server1 kernel: [155538.083632]   Tx Queue             <56>
2020-04-06T08:35:25.256458-05:00 dell-server1 kernel: [155538.083632]   TDH, TDT             <0>, <4>
2020-04-06T08:35:25.256460-05:00 dell-server1 kernel: [155538.083632]   next_to_use          <4>
2020-04-06T08:35:25.256461-05:00 dell-server1 kernel: [155538.083632]   next_to_clean        <0>
2020-04-06T08:35:25.256463-05:00 dell-server1 kernel: [155538.083632] tx_buffer_info[next_to_clean]
2020-04-06T08:35:25.256464-05:00 dell-server1 kernel: [155538.083632]   time_stamp           <1025039f0>
2020-04-06T08:35:25.256467-05:00 dell-server1 kernel: [155538.083632]   jiffies              <102503cb8>
2020-04-06T08:35:25.256469-05:00 dell-server1 kernel: [155538.083634] ixgbe 0000:19:00.0 eno1: Detected Tx Unit Hang
2020-04-06T08:35:25.256470-05:00 dell-server1 kernel: [155538.083634]   Tx Queue             <55>
(...and this process repeats itself, even after rmmod'ing ixgbe and modprobe'ing it back...)

The reason I say it's a high incidence is that we have about 100 of these NICs and have already seen it on 4 or 5 of them. 3 of them were on 19.0 firmware when it happened but this latest one was on 19.5 firmware when it happened.

I'm skeptical of this "ECC Err" that triggers it since they're all fairly new servers and having bad memory on that many NICs is still abnormally high. In that same vein, the main system DIMMs don't report any errors or anything to indicate that there are multi-bit or even single-bit errors going on.

Are there any further diagnostic tools I could use to figure out what's going on here? I can't seem to reproduce the issue by sending high packet load at the cards or anything. Or is this a bug that you all are aware of?


Thanks!

-Kevin


______________________________________________________________________
See http://www.peak6.com/email_disclaimer/ for terms and conditions related to this email
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200406/e54ec385/attachment-0001.html>
