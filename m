From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Mon, 31 Jan 2022 17:41:05 +0100
Subject: [Intel-wired-lan] [PATCH net] net: e1000e: Recover at least
 in-memory copy of NVM checksum
In-Reply-To: <d32ac7da-f460-6d7a-5f7f-9c9d873bf393@intel.com>
References: <20220127150807.26448-1-tbogendoerfer@suse.de>
 <d32ac7da-f460-6d7a-5f7f-9c9d873bf393@intel.com>
Message-ID: <20220131164105.GA29636@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jan 31, 2022 at 12:51:07PM +0200, Neftin, Sasha wrote:
> Hello Thomas,
> For security reasons starting from the TGL platform SPI controller will be
> locked for SW access. I've double-checked with our HW architect, not from
> SPT, from TGP. So, first, we can change the mac type e1000_pch_cnp to
> e1000_pch_tgp (as fix for initial patch)

ok, that would fix the mentioned bug. Are you sending a patch for that ?

> Do we want (second) to allow HW initialization with the "wrong" NVM
> checksum? It could cause unexpected (HW) behavior in the future. Even if you
> will "recover" check in shadow RAM - there is no guarantee that NVM is good.

sure. Out of curiosity why is the NVM fixup there in the first place ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
