From: David Miller <davem@davemloft.net>
Date: Thu, 07 Mar 2019 09:29:29 -0800 (PST)
Subject: [Intel-wired-lan] [PATCH] igc: remove unused
 igc_priv_flags_strings array
In-Reply-To: <20190307093014.3293229-1-arnd@arndb.de>
References: <20190307093014.3293229-1-arnd@arndb.de>
Message-ID: <20190307.092929.277930617530301779.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu,  7 Mar 2019 10:29:57 +0100

> clang points out that the igc_priv_flags_strings[] array is never
> referenced, aside from being used for calculating its length:
> 
> drivers/net/ethernet/intel/igc/igc_ethtool.c:9:19: error: variable 'igc_priv_flags_strings' is not needed and will not
>       be emitted [-Werror,-Wunneeded-internal-declaration]
> static const char igc_priv_flags_strings[][ETH_GSTRING_LEN] = {
> 
> A similar array is present in several other intel ethernet drivers,
> but all the others use it in their .get_strings() callback, which
> igc does not implement (yet).
> 
> Probably it should be implemented, but as I have no way of testing
> it, this does the simpler alternative of removing the array to
> get rid of the warning.
> 
> Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Jeff, I assume you will pick this up.
