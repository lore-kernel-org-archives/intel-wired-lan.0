From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 6 Jul 2020 08:13:00 +0200
Subject: [Intel-wired-lan] [bug ?] i40e_rx_buffer_flip should not be
 called for redirected xsk copy mode
In-Reply-To: <2863b548da1d4c369bbd9d6ceb337a24@baidu.com>
References: <2863b548da1d4c369bbd9d6ceb337a24@baidu.com>
Message-ID: <CAJ8uoz08pyWR43K_zhp6PsDLi0KE=y_4QTs-a7kBA-jkRQksaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thank you RongQing for reporting this. I will take a look at it and
produce a patch.

/Magnus

On Thu, Jul 2, 2020 at 11:33 AM Li,Rongqing <lirongqing@baidu.com> wrote:
>
> Hi:
>
>
>
> i40e_rx_buffer_flip to xsk copy mode can lead to data corruption, like the following flow:
>
>
>
> 1. first skb is not for xsk, and forwarded to another device or socket queue
>
> 2. seconds skb is for xsk, copy data to xsk memory, and page of skb->data is released
>
> 3. rx_buff is reusable since only first skb is in it, but i40e_rx_buffer_flip will make that page_offset is set to first skb data
>
> 4. then reuse rx buffer, first skb which still is living will be corrupted.
>
>
>
> -Li RongQing
>
>
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
