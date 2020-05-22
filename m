From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 May 2020 20:09:26 +0000
Subject: [Intel-wired-lan] [PATCH S43 15/15] ice: Add more Rx errors to
 netdev's rx_error counter
In-Reply-To: <20200516003644.4658-15-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
 <20200516003644.4658-15-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16594A1E37F062DAA051101B8CB40@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S43 15/15] ice: Add more Rx errors to
> netdev's rx_error counter
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently we are only including illegal_bytes and rx_crc_errors in the PF
> netdev's rx_error counter. There are many more causes of Rx errors that the
> device supports and reports via Ethtool. Accumulate all Rx errors in the PF
> netdev's rx_error counter.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


