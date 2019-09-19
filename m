From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 19 Sep 2019 17:20:09 +0000
Subject: [Intel-wired-lan] [linux-firmware] ice: Add package file for
 Intel E800 series driver
In-Reply-To: <20190917133817.24253-1-anthony.l.nguyen@intel.com>
References: <20190917133817.24253-1-anthony.l.nguyen@intel.com>
Message-ID: <bdc99e110c034683b9dc45e4736bf107@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, September 17, 2019 6:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [linux-firmware] ice: Add package file for Intel E800
> series driver
> 
> The ice driver must load a package file to the firmware to utilize full
> functionality; add the package file to /lib/firmware/intel/ice/ddp. Also
> add a symlink, ice.pkg, so the driver can refer to the package by a
> consistent name.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  LICENSE.ice                   |  39 ++++++++++++++++++++++++++++++++++
>  WHENCE                        |   9 ++++++++
>  intel/ice/ddp/ice-1.3.4.0.pkg | Bin 0 -> 577796 bytes
>  intel/ice/ddp/ice.pkg         |   1 +
>  4 files changed, 49 insertions(+)
>  create mode 100644 LICENSE.ice
>  create mode 100644 intel/ice/ddp/ice-1.3.4.0.pkg
>  create mode 120000 intel/ice/ddp/ice.pkg

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


