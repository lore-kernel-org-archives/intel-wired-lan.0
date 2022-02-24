From: Harald Welte <laforge@gnumonks.org>
Date: Thu, 24 Feb 2022 23:42:36 +0100
Subject: [Intel-wired-lan] [PATCH net-next v9 3/7] gtp: Implement GTP
 echo request
In-Reply-To: <20220224185500.18384-4-marcin.szycik@linux.intel.com>
References: <20220224185500.18384-1-marcin.szycik@linux.intel.com>
 <20220224185500.18384-4-marcin.szycik@linux.intel.com>
Message-ID: <YhgJ3JYKWtxMSPkQ@nataraja>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Wojciech,

thanks again for your revision of the patches.

On Thu, Feb 24, 2022 at 07:54:56PM +0100, Marcin Szycik wrote:
> When GTP echo response is detected, multicast message is
> send to everyone in the gtp_genl_family. Message contains
> GTP version, ms address and peer address.

I think many will perceive this as rather odd, but I think it is the
least bad thing we can do in this situation.

> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Suggested-by: Harald Welte <laforge@gnumonks.org>

Reviewed-by: Harald Welte <laforge@gnumonks.org>

Regards,
	Harald
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
