From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 28 Jun 2019 11:53:03 -0700
Subject: [Intel-wired-lan] [PATCH 24/39] docs: driver-model: move it to
 the driver-api book
In-Reply-To: <920ff36c66233113b1825ab504fe675ed5a5bd7b.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
 <920ff36c66233113b1825ab504fe675ed5a5bd7b.1561724493.git.mchehab+samsung@kernel.org>
Message-ID: <fee5dd422d88806ee0b5a6b84f14cd6d50351343.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2019-06-28 at 09:30 -0300, Mauro Carvalho Chehab wrote:
> The audience for the Kernel driver-model is clearly Kernel hackers.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

For the 'ice' driver changes.

> ---
>  Documentation/{ => driver-api}/driver-model/binding.rst       | 0
>  Documentation/{ => driver-api}/driver-model/bus.rst           | 0
>  Documentation/{ => driver-api}/driver-model/class.rst         | 0
>  .../{ => driver-api}/driver-model/design-patterns.rst         | 0
>  Documentation/{ => driver-api}/driver-model/device.rst        | 0
>  Documentation/{ => driver-api}/driver-model/devres.rst        | 0
>  Documentation/{ => driver-api}/driver-model/driver.rst        | 0
>  Documentation/{ => driver-api}/driver-model/index.rst         | 2 --
>  Documentation/{ => driver-api}/driver-model/overview.rst      | 0
>  Documentation/{ => driver-api}/driver-model/platform.rst      | 0
>  Documentation/{ => driver-api}/driver-model/porting.rst       | 2 +-
>  Documentation/driver-api/gpio/driver.rst                      | 2 +-
>  Documentation/driver-api/index.rst                            | 1 +
>  Documentation/eisa.txt                                        | 4 ++--
>  Documentation/filesystems/sysfs.txt                           | 2 +-
>  Documentation/hwmon/submitting-patches.rst                    | 2 +-
>  Documentation/translations/zh_CN/filesystems/sysfs.txt        | 2 +-
>  drivers/base/platform.c                                       | 2 +-
>  drivers/gpio/gpio-cs5535.c                                    | 2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c                     | 2 +-
>  drivers/staging/unisys/Documentation/overview.txt             | 4 ++--
>  include/linux/device.h                                        | 2 +-
>  include/linux/platform_device.h                               | 2 +-
>  scripts/coccinelle/free/devm_free.cocci                       | 2 +-
>  24 files changed, 16 insertions(+), 17 deletions(-)
>  rename Documentation/{ => driver-api}/driver-model/binding.rst (100%)
>  rename Documentation/{ => driver-api}/driver-model/bus.rst (100%)
>  rename Documentation/{ => driver-api}/driver-model/class.rst (100%)
>  rename Documentation/{ => driver-api}/driver-model/design-patterns.rst
> (100%)
>  rename Documentation/{ => driver-api}/driver-model/device.rst (100%)
>  rename Documentation/{ => driver-api}/driver-model/devres.rst (100%)
>  rename Documentation/{ => driver-api}/driver-model/driver.rst (100%)
>  rename Documentation/{ => driver-api}/driver-model/index.rst (96%)
>  rename Documentation/{ => driver-api}/driver-model/overview.rst (100%)
>  rename Documentation/{ => driver-api}/driver-model/platform.rst (100%)
>  rename Documentation/{ => driver-api}/driver-model/porting.rst (99%)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190628/d95c49aa/attachment.asc>
