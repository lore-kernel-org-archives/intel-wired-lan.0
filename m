From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Jan 2020 23:18:58 +0000
Subject: [Intel-wired-lan] [PATCH S38 12/15] ice: replace "fallthrough"
 comments with fallthrough reserved word
In-Reply-To: <20200122152138.41585-12-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
 <20200122152138.41585-12-anthony.l.nguyen@intel.com>
Message-ID: <cb08a6399dca4d4ca992d104221d200e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:22 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S38 12/15] ice: replace "fallthrough"
> comments with fallthrough reserved word
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> "fallthrough" comments are used in switch case statements to explicitly
> indicate the code is intended to fall through to the following statement.
> Different variants of "fallthough" are acceptable, e.g. "fall through",
> "fallthrough", "Fall-through".  The GCC compiler has an optional warning
> (-Wimplicit-fallthrough[=n]) to warn when such a comment is not present;
> the default version of which is enabled when compiling the Linux kernel.
> 
> There have been recent discussions in kernel mailing lists regarding replacing
> non-standardized "fallthrough" comments with the pseudo-reserved word
> 'fallthrough' which will be defined as __attribute__ ((fallthrough)) for
> versions of gcc that support it (i.e. gcc 7 and newer) or as a nop for versions
> that do not.  Replace "fallthrough" comments with fallthrough reserved
> word.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_main.c   | 2 +-
>  drivers/net/ethernet/intel/ice/ice_switch.c | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_txrx.c   | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_xsk.c    | 4 ++--
>  5 files changed, 9 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


