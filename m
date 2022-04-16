From: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Date: Sat, 16 Apr 2022 03:19:20 +0200
Subject: [Intel-wired-lan] [PATCH v2] intel: igb: igb_ethtool.c: Convert
 kmap() to kmap_local_page()
Message-ID: <20220416011920.5380-1-eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The use of kmap() is being deprecated in favor of kmap_local_page()
where it is feasible.

With kmap_local_page(), the mapping is per thread, CPU local and not
globally visible.

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
changes in V2:
	fix kunmap_local path value to be address
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 2a5782063f4c..c14fc871dd41 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -1798,14 +1798,14 @@ static int igb_check_lbtest_frame(struct igb_rx_buffer *rx_buffer,
 
 	frame_size >>= 1;
 
-	data = kmap(rx_buffer->page);
+	data = kmap_local_page(rx_buffer->page);
 
 	if (data[3] != 0xFF ||
 	    data[frame_size + 10] != 0xBE ||
 	    data[frame_size + 12] != 0xAF)
 		match = false;
 
-	kunmap(rx_buffer->page);
+	kunmap_local(data);
 
 	return match;
 }
-- 
2.35.2

