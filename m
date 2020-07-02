From: Li,Rongqing <lirongqing@baidu.com>
Date: Thu, 2 Jul 2020 09:17:49 +0000
Subject: [Intel-wired-lan] [bug ?] i40e_rx_buffer_flip should not be called
 for redirected xsk copy mode
Message-ID: <2863b548da1d4c369bbd9d6ceb337a24@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi:

i40e_rx_buffer_flip to xsk copy mode can lead to data corruption, like the following flow:

1. first skb is not for xsk, and forwarded to another device or socket queue
2. seconds skb is for xsk, copy data to xsk memory, and page of skb->data is released
3. rx_buff is reusable since only first skb is in it, but i40e_rx_buffer_flip will make that page_offset is set to first skb data
4. then reuse rx buffer, first skb which still is living will be corrupted.

-Li RongQing

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200702/810347e7/attachment.html>
