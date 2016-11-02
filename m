From: Benjamin Poirier <bpoirier@suse.com>
Date: Wed, 2 Nov 2016 12:25:21 +0900
Subject: [Intel-wired-lan] Kernel regression introduced by "e1000e: Do
 not write lsc to ics in msi-x mode" and/or "e1000e: Do not read ICR in
 Other interrupt"
In-Reply-To: <1478044618.14119.774423193.0F79737A@webmail.messagingengine.com>
References: <1478044618.14119.774423193.0F79737A@webmail.messagingengine.com>
Message-ID: <20161102032521.vhatcp47yqych6rt@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2016/11/01 19:56, Jack Suter wrote:
> Hi there,
> 
> I have some servers with an 82574L based NIC and recently upgraded from
> a 4.4 series kernel to 4.7. Upon doing so, servers with this chipset
> have begun frequently reporting "Link is Down" and "Link is Up"
> messages. No other related network errors are reported by the kernel or
> e1000e driver. I saw some reports about using "ethtool -s $iface msglvl
> 6" to reveal more information, but nothing extra was reported.
> 
> Some testing showed that this was introduced between the 4.4 and 4.5
> series. I was able to further narrow it down to two commits that look
> related:
> 
>  e1000e: Do not write lsc to ics in msi-x mode
>  (a61cfe4ffad7864a07e0c74969ca7ceb77ab2f1f)
>  e1000e: Do not read ICR in Other interrupt
>  (16ecba59bc333d6282ee057fb02339f77a880beb)

I'm just about to get on a plane but I'll be able to look at this on
Monday. Two guesses are that:
1) There is something else than LSC that triggers the "other" interrupt.
Even if that is so, it should not cause e1000e_check_for_copper_link to
report link down however.
2) The link down events are real but some lsc interrupts were not
processed properly prior to this patchset, causing the events to be
lost/ignored.
