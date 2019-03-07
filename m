From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 7 Mar 2019 09:37:13 -0800
Subject: [Intel-wired-lan] [PATCH] igc: remove unused
 igc_priv_flags_strings array
In-Reply-To: <20190307.092929.277930617530301779.davem@davemloft.net>
References: <20190307093014.3293229-1-arnd@arndb.de>
 <20190307.092929.277930617530301779.davem@davemloft.net>
Message-ID: <dbc02b0b-8f85-cdc9-2e8d-9a29adefbf6b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/7/2019 09:29, David Miller wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Thu,  7 Mar 2019 10:29:57 +0100
> 
>> clang points out that the igc_priv_flags_strings[] array is never
>> referenced, aside from being used for calculating its length:
>>
>> drivers/net/ethernet/intel/igc/igc_ethtool.c:9:19: error: variable 'igc_priv_flags_strings' is not needed and will not
>>        be emitted [-Werror,-Wunneeded-internal-declaration]
>> static const char igc_priv_flags_strings[][ETH_GSTRING_LEN] = {
>>
>> A similar array is present in several other intel ethernet drivers,
>> but all the others use it in their .get_strings() callback, which
>> igc does not implement (yet).
>>
>> Probably it should be implemented, but as I have no way of testing
>> it, this does the simpler alternative of removing the array to
>> get rid of the warning.
>>
>> Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Jeff, I assume you will pick this up.
> 
I've submitted igc: Add support for statistics commit 
7aa2547613233a232b9b2e1942d67da4997e6ad0. This patch in Jeff's Kirsher 
next-queue and used igc_priv_flags_strings.
Thanks,
Sasha
