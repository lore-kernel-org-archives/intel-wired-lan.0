From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 12 Jun 2019 13:21:38 -0700
Subject: [Intel-wired-lan] [PATCH v1 09/31] docs: driver-model: convert
 docs to ReST and rename to *.rst
In-Reply-To: <c90bb60d65aaba4ce5957894cc6890ebe5048d95.1560364494.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
 <c90bb60d65aaba4ce5957894cc6890ebe5048d95.1560364494.git.mchehab+samsung@kernel.org>
Message-ID: <5e818fb4bf253fc69259093e7ff68122e4a4044c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2019-06-12 at 15:38 -0300, Mauro Carvalho Chehab wrote:
> Convert the various documents at the driver-model, preparing
> them to be part of the driver-api book.
> 
> The conversion is actually:
>   - add blank lines and identation in order to identify paragraphs;
>   - fix tables markups;
>   - add some lists markups;
>   - mark literal blocks;
>   - adjust title markups.
> 
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

For the ice driver comment change.

> ---
>  Documentation/driver-api/gpio/driver.rst      |   2 +-
>  .../driver-model/{binding.txt => binding.rst} |  20 +-
>  .../driver-model/{bus.txt => bus.rst}         |  69 ++--
>  .../driver-model/{class.txt => class.rst}     |  74 ++--
>  ...esign-patterns.txt => design-patterns.rst} | 106 +++---
>  .../driver-model/{device.txt => device.rst}   |  57 +--
>  .../driver-model/{devres.txt => devres.rst}   |  50 +--
>  .../driver-model/{driver.txt => driver.rst}   | 112 +++---
>  Documentation/driver-model/index.rst          |  26 ++
>  .../{overview.txt => overview.rst}            |  37 +-
>  .../{platform.txt => platform.rst}            |  30 +-
>  .../driver-model/{porting.txt => porting.rst} | 333 +++++++++---------
>  Documentation/eisa.txt                        |   4 +-
>  Documentation/hwmon/submitting-patches.rst    |   2 +-
>  drivers/base/platform.c                       |   2 +-
>  drivers/gpio/gpio-cs5535.c                    |   2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |   2 +-
>  scripts/coccinelle/free/devm_free.cocci       |   2 +-
>  18 files changed, 489 insertions(+), 441 deletions(-)
>  rename Documentation/driver-model/{binding.txt => binding.rst} (92%)
>  rename Documentation/driver-model/{bus.txt => bus.rst} (76%)
>  rename Documentation/driver-model/{class.txt => class.rst} (75%)
>  rename Documentation/driver-model/{design-patterns.txt => design-
> patterns.rst} (59%)
>  rename Documentation/driver-model/{device.txt => device.rst} (71%)
>  rename Documentation/driver-model/{devres.txt => devres.rst} (93%)
>  rename Documentation/driver-model/{driver.txt => driver.rst} (75%)
>  create mode 100644 Documentation/driver-model/index.rst
>  rename Documentation/driver-model/{overview.txt => overview.rst} (90%)
>  rename Documentation/driver-model/{platform.txt => platform.rst} (95%)
>  rename Documentation/driver-model/{porting.txt => porting.rst} (62%)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190612/701c155a/attachment.asc>
