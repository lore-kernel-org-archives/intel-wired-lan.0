From: Harald Welte <laforge@gnumonks.org>
Date: Thu, 24 Feb 2022 23:44:11 +0100
Subject: [Intel-wired-lan] [PATCH net-next v9 0/7] ice: GTP support in
 switchdev
In-Reply-To: <20220224185500.18384-1-marcin.szycik@linux.intel.com>
References: <20220224185500.18384-1-marcin.szycik@linux.intel.com>
Message-ID: <YhgKO8rdxMxclZPm@nataraja>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Marcin,

On Thu, Feb 24, 2022 at 07:54:53PM +0100, Marcin Szycik wrote:
> Add support for adding GTP-C and GTP-U filters in switchdev mode.

For the changes to the gtp.ko driver this v9 looks fine to me.  I cannot
comment about the switchdevs bits, those are beyond my expertise.

Regards,
	Harald
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
