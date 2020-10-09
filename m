From: ira.weiny@intel.com <ira.weiny@intel.com>
Date: Fri,  9 Oct 2020 12:49:42 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 07/58] drivers/drbd: Utilize
 new kmap_thread()
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
Message-ID: <20201009195033.3208459-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ira Weiny <ira.weiny@intel.com>

The kmap() calls in this driver are localized to a single thread.  To
avoid the over head of global PKRS updates use the new kmap_thread()
call.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/block/drbd/drbd_main.c     |  4 ++--
 drivers/block/drbd/drbd_receiver.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 573dbf6f0c31..f0d0c6b0745e 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1532,9 +1532,9 @@ static int _drbd_no_send_page(struct drbd_peer_device *peer_device, struct page
 	int err;
 
 	socket = peer_device->connection->data.socket;
-	addr = kmap(page) + offset;
+	addr = kmap_thread(page) + offset;
 	err = drbd_send_all(peer_device->connection, socket, addr, size, msg_flags);
-	kunmap(page);
+	kunmap_thread(page);
 	if (!err)
 		peer_device->device->send_cnt += size >> 9;
 	return err;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 422363daa618..4704bc0564e2 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1951,13 +1951,13 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 	page = peer_req->pages;
 	page_chain_for_each(page) {
 		unsigned len = min_t(int, ds, PAGE_SIZE);
-		data = kmap(page);
+		data = kmap_thread(page);
 		err = drbd_recv_all_warn(peer_device->connection, data, len);
 		if (drbd_insert_fault(device, DRBD_FAULT_RECEIVE)) {
 			drbd_err(device, "Fault injection: Corrupting data on receive\n");
 			data[0] = data[0] ^ (unsigned long)-1;
 		}
-		kunmap(page);
+		kunmap_thread(page);
 		if (err) {
 			drbd_free_peer_req(device, peer_req);
 			return NULL;
@@ -1992,7 +1992,7 @@ static int drbd_drain_block(struct drbd_peer_device *peer_device, int data_size)
 
 	page = drbd_alloc_pages(peer_device, 1, 1);
 
-	data = kmap(page);
+	data = kmap_thread(page);
 	while (data_size) {
 		unsigned int len = min_t(int, data_size, PAGE_SIZE);
 
@@ -2001,7 +2001,7 @@ static int drbd_drain_block(struct drbd_peer_device *peer_device, int data_size)
 			break;
 		data_size -= len;
 	}
-	kunmap(page);
+	kunmap_thread(page);
 	drbd_free_pages(peer_device->device, page, 0);
 	return err;
 }
@@ -2033,10 +2033,10 @@ static int recv_dless_read(struct drbd_peer_device *peer_device, struct drbd_req
 	D_ASSERT(peer_device->device, sector == bio->bi_iter.bi_sector);
 
 	bio_for_each_segment(bvec, bio, iter) {
-		void *mapped = kmap(bvec.bv_page) + bvec.bv_offset;
+		void *mapped = kmap_thread(bvec.bv_page) + bvec.bv_offset;
 		expect = min_t(int, data_size, bvec.bv_len);
 		err = drbd_recv_all_warn(peer_device->connection, mapped, expect);
-		kunmap(bvec.bv_page);
+		kunmap_thread(bvec.bv_page);
 		if (err)
 			return err;
 		data_size -= expect;
-- 
2.28.0.rc0.12.gb6a658bd00c9

