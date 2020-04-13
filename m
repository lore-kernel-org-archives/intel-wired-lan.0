From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Sun, 12 Apr 2020 23:35:48 -0700
Subject: [Intel-wired-lan] [PATCH 5/7] PM: sleep: core: Rename
 DPM_FLAG_NEVER_SKIP
In-Reply-To: <5092680.jloV5Ae5OO@kreacher>
References: <1888197.j9z7NJ8yPn@kreacher> <5092680.jloV5Ae5OO@kreacher>
Message-ID: <CAL3LdT71aa3NfqoGTvmz-XzS7Ng=LqpwPROWyf=w_+PyvEET-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Apr 10, 2020 at 9:03 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Rename DPM_FLAG_NEVER_SKIP to DPM_FLAG_NO_DIRECT_COMPLETE which
> matches its purpose more closely.
>
> No functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

For the driver changes to e1000e, igb and igc.

> ---
>  Documentation/driver-api/pm/devices.rst    |  6 +++---
>  Documentation/power/pci.rst                | 10 +++++-----
>  drivers/base/power/main.c                  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 +-
>  drivers/gpu/drm/i915/intel_runtime_pm.c    |  2 +-
>  drivers/gpu/drm/radeon/radeon_kms.c        |  2 +-
>  drivers/misc/mei/pci-me.c                  |  2 +-
>  drivers/misc/mei/pci-txe.c                 |  2 +-
>  drivers/net/ethernet/intel/e1000e/netdev.c |  2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c  |  2 +-
>  drivers/net/ethernet/intel/igc/igc_main.c  |  2 +-
>  drivers/pci/pcie/portdrv_pci.c             |  2 +-
>  include/linux/pm.h                         |  6 +++---
>  13 files changed, 21 insertions(+), 21 deletions(-)
>
