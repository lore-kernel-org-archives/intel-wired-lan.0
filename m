From: Joe Damato <jdamato@fastly.com>
Date: Wed, 13 Apr 2022 09:41:41 -0700
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 235/256]
 drivers/net/ethernet/intel/ice/ice_txrx.c:1971:16: error: redeclaration of
 'protocol' with no linkage
In-Reply-To: <bcdfdf24-bd8c-f487-5a26-88ee0b1bdb43@intel.com>
References: <202204140015.MRcE3hbT-lkp@intel.com>
 <bcdfdf24-bd8c-f487-5a26-88ee0b1bdb43@intel.com>
Message-ID: <20220413164140.GA9392@fastly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Apr 13, 2022 at 09:40:24AM -0700, Tony Nguyen wrote:
> 
> On 4/13/2022 9:35 AM, kernel test robot wrote:
> >tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
> >head:   faadd15618a12d7b11208f11c54d6ac0f2776486
> >commit: 5d4c82c60dd05a844ff582c2c6d4e8c3c3020ebc [235/256] ice: Add mpls+tso support
> >config: powerpc-buildonly-randconfig-r003-20220413 (https://download.01.org/0day-ci/archive/20220414/202204140015.MRcE3hbT-lkp at intel.com/config)
> >compiler: powerpc-linux-gcc (GCC) 11.2.0
> >reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=5d4c82c60dd05a844ff582c2c6d4e8c3c3020ebc
> >         git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
> >         git fetch --no-tags tnguy-next-queue dev-queue
> >         git checkout 5d4c82c60dd05a844ff582c2c6d4e8c3c3020ebc
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/intel/ice/
> >
> >If you fix the issue, kindly add following tag as appropriate
> >Reported-by: kernel test robot <lkp@intel.com>
> >
> >All errors (new ones prefixed by >>):
> >
> >    drivers/net/ethernet/intel/ice/ice_txrx.c: In function 'ice_tso':
> >>>drivers/net/ethernet/intel/ice/ice_txrx.c:1971:16: error: redeclaration of 'protocol' with no linkage
> 
> Hi Joe,
> 
> You can ignore this, this was a mistake on my part and I've fixed it.

No worries; thanks for letting me know.

Thanks,
Joe
