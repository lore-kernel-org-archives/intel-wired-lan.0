From: David Miller <davem@davemloft.net>
Date: Fri, 09 Dec 2016 23:07:40 -0500 (EST)
Subject: [Intel-wired-lan] [PATCH] i40e: don't truncate match_method
	assignment
In-Reply-To: <20161209213921.26451-1-jacob.e.keller@intel.com>
References: <20161209213921.26451-1-jacob.e.keller@intel.com>
Message-ID: <20161209.230740.2078488933726675303.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  9 Dec 2016 13:39:21 -0800

> The .match_method field is a u8, so we shouldn't be casting to a u16,
> and because it is only one byte, we do not need to byte swap anything.
> Just assign the value directly. This avoids issues on Big Endian
> architectures which would have byte swapped and then incorrectly
> truncated the value.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Bimmy Pujari <bimmy.pujari@intel.com>
> ---
> Not sure if this was already in Jeff's queue, but since it's an obvious
> fix for the issue found by Stephen, I thought I'd send it out now just
> to make sure. Thanks for catching this, and sorry we didn't find the fix
> earlier.

Jeff, what do you want me to do with this?
