From: Doron Shikmoni <doron.shikmoni@gmail.com>
Date: Sun, 27 Sep 2015 13:36:22 +0300
Subject: [Intel-wired-lan] [PATCH] igb: garbled "ethtool -m" output in
 igb-driven NICs, patch for igb_get_module_eeprom()
Message-ID: <CAEvZX5eZjLdD9O97EUXiBqWcnfoHrVp93tfVEHt7Mk2tEanr4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

For igb-driven NICs with module/plugin EEPROM, "ethtool -m ethX" provides
garbled output (every time). Each data byte appears to be duplicated.

The issue is within igb_get_module_eeprom() in igb_ethtool.c. In the reading
of the EEPROM via i2c, the eeprom offset for each word that's read via
igb_read_phy_reg_i2c() is passed in #words, whereas it needs to be a byte
offset.

Signed-off-by: Doron Shikmoni <doron.shikmoni@gmail.com>
---

Proposed patch tested; with this patch applied, the output of "ethtool -m"
appears perfect. It'd be great if you could push this into the main tree.

[ "(first_word + i ) * 2" and not "ee->offset + i", due to word boundary ]


diff -up igb_ethtool.c igb_ethtool.c.patched
--- igb_ethtool.c
+++ igb_ethtool.c.patched
@@ -2808,7 +2808,7 @@ static int igb_get_module_eeprom(struct

        /* Read EEPROM block, SFF-8079/SFF-8472, word at a time */
        for (i = 0; i < last_word - first_word + 1; i++) {
-               status = igb_read_phy_reg_i2c(hw, first_word + i,
&dataword[i]);
+               status = igb_read_phy_reg_i2c(hw, (first_word + i) * 2,
&dataword[i]);
                if (status) {
                        /* Error occurred while reading module */
                        kfree(dataword);
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150927/cf12f26b/attachment.html>
