From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 22 Jun 2020 16:55:39 -0700
Subject: [Intel-wired-lan] [PATCH 06/11] phy: un-inline
 devm_mdiobus_register()
In-Reply-To: <20200622100056.10151-7-brgl@bgdev.pl>
References: <20200622100056.10151-1-brgl@bgdev.pl>
 <20200622100056.10151-7-brgl@bgdev.pl>
Message-ID: <39e761f3-6607-d209-61df-535330f50db3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/22/20 3:00 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Functions should only be static inline if they're very short. This
> devres helper is already over 10 lines and it will grow soon as we'll
> be improving upon its approach. Pull it into mdio_devres.c.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/net/phy/Makefile      |  2 +-
>  drivers/net/phy/mdio_devres.c | 18 ++++++++++++++++++
>  include/linux/phy.h           | 15 ++-------------
>  3 files changed, 21 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/net/phy/mdio_devres.c

This would likely require an update to the MAINTAINERS file for this new
file to be picked up by the correct entry.
-- 
Florian
