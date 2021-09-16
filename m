From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 16 Sep 2021 22:07:04 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Add support for
 50G/100G in AIM algorithm
In-Reply-To: <20210915091559.27096-1-mateusz.palczewski@intel.com>
References: <20210915091559.27096-1-mateusz.palczewski@intel.com>
Message-ID: <02f5ca336393cd78b0fe366a85bc4f75c935b226.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-09-15 at 11:15 +0200, Mateusz Palczewski wrote:
> Advanced link speed support was added long back, but adding AIM
> support
> was missed. Adding AIM support for advanced link speed support
> allows the algorithm to take into account 50G/100G link speeds.
> Also, other previous speeds are taken into consideration when
> advanced
> link speeds are supported.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>

This has build issues:

../drivers/net/ethernet/intel/iavf/iavf_txrx.c:404:1: error: stray \342
in program
 <200b>
 ^
../drivers/net/ethernet/intel/iavf/iavf_txrx.c:404:2: error: stray \200
in program
 <200b>
  ^
../drivers/net/ethernet/intel/iavf/iavf_txrx.c:404:3: error: stray \213
in program
 <200b>
   ^
../drivers/net/ethernet/intel/iavf/iavf_txrx.c:422:1: error: stray \342
in program
 <200b>
 ^
../drivers/net/ethernet/intel/iavf/iavf_txrx.c:422:2: error: stray \200
in program
 <200b>
  ^
../drivers/net/ethernet/intel/iavf/iavf_txrx.c:422:3: error: stray \213
in program
 <200b>
   ^

