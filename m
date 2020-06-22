From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 22 Jun 2020 15:49:43 -0700
Subject: [Intel-wired-lan] [PATCH 03/11] net: devres: relax
 devm_register_netdev()
In-Reply-To: <20200622100056.10151-4-brgl@bgdev.pl>
References: <20200622100056.10151-1-brgl@bgdev.pl>
 <20200622100056.10151-4-brgl@bgdev.pl>
Message-ID: <20200622154943.02782b5a@kicinski-fedora-PC1C0HJN>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 22 Jun 2020 12:00:48 +0200 Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This devres helper registers a release callback that only unregisters
> the net_device. It works perfectly fine with netdev structs that are
> not managed on their own. There's no reason to check this - drop the
> warning.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I think the reasoning for this suggestion was to catch possible UAF
errors. The netdev doesn't necessarily has to be from devm_alloc_* 
but it has to be part of devm-ed memory or memory which is freed 
after driver's remove callback.

Are there cases in practice where you've seen the netdev not being
devm allocated?
