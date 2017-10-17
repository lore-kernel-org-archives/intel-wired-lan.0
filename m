From: Henrik Austad <henrik@austad.us>
Date: Tue, 17 Oct 2017 13:35:50 +0200
Subject: [Intel-wired-lan] [next-queue PATCH v9 0/6] TSN: Add qdisc
 based config interface for CBS
In-Reply-To: <20171017010128.22141-1-vinicius.gomes@intel.com>
References: <20171017010128.22141-1-vinicius.gomes@intel.com>
Message-ID: <20171017113550.GA17834@sisyphus.home.austad.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 16, 2017 at 06:01:22PM -0700, Vinicius Costa Gomes wrote:
> Hi,

Vinicius; this looks really good to me, testing shows no errors and 
behavior is as expected. I see some differences in received bw for 
offload=1 and 0 though

Just using tsn_talker and tsn_listener:
tc qdisc add dev eth2 parent 8001:1 cbs idleslope 20000 sendslope -980000 \
hicredit 30 locredit -1470 offload 1

with offload=1 (20Mbps BW)
Receiving data rate: 19420 kbps
Receiving data rate: 19410 kbps

Similarly, but with offload=0 (SW, 20Mbps BW)
Receiving data rate: 19980 kbps
Receiving data rate: 20170 kbps

So slightly higer variance in rate when doing SW, which is as expected.

I plan to run this through some more tests tomorrow and measure variance on the 
receiver etc, I'll keep you posted on my findings.

Feel free to add a tested-by though

Tested-by: Henrik Austad <henrik@austad.us>

and a Vehemently-supported-by: Henrik .. :)

-Henrik
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171017/5de52d41/attachment.asc>
