From: Yury Norov <yury.norov@gmail.com>
Date: Thu, 10 Feb 2022 14:49:12 -0800
Subject: [Intel-wired-lan] [PATCH 28/49] iio: replace bitmap_weight() with
 bitmap_weight_{eq, gt} where appropriate
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
Message-ID: <20220210224933.379149-29-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

drivers/iio calls bitmap_weight() to compare the weight of bitmap with
a given number. We can do it more efficiently with bitmap_weight_eq
because conditional bitmap_weight may stop traversing the bitmap earlier,
as soon as condition is (or can't be) met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index f504ed351b3e..98c54022fecf 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -331,7 +331,7 @@ int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(pf->indio_dev);
 	bool no_other_users =
-		bitmap_weight(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER) == 1;
+		bitmap_weight_eq(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER, 1);
 	int ret = 0;
 
 	if (trig->ops && trig->ops->set_trigger_state && no_other_users) {
-- 
2.32.0

