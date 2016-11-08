From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Tue, 8 Nov 2016 16:05:53 +0000
Subject: [Intel-wired-lan] i40e performance regression after 1.3.9 ?
In-Reply-To: <aea231d5-64bb-97e7-57f6-cf845629d9ef@isc.org>
References: <9f9f62ec-fbce-534a-d2bd-e918a03a3899@isc.org>
 <CAKgT0Uc9W_tvMEoKzLzBG-pK7Sjznr3B+xgjne0tUuTX17d+Hg@mail.gmail.com>
 <fe40bb83-d28c-8fc4-148a-37ff7ad5c7aa@isc.org>
 <CAKgT0UfB-ofJw6gA2f-FJvBcn-4Qd52DrQuth828xWkp8+WSDg@mail.gmail.com>
 <aea231d5-64bb-97e7-57f6-cf845629d9ef@isc.org>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B626502D1704@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Ray Bellis
> Sent: Tuesday, November 08, 2016 2:31 AM
> To: Alexander Duyck <alexander.duyck@gmail.com>
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] i40e performance regression after 1.3.9 ?
> 
> On 07/11/2016 20:44, Alexander Duyck wrote:
> 
> > The adaptive Rx and Tx being disabled is the important part.  If you
> > didn't do that then changing the other values really had no effect.
> 
> I've just confirmed that turning off adaptive Rx and Tx on the "server"
> side has the desired effect, bringing my packet rate back up to 1.3+ Mpps.
> 
> I'm getting odd effects when I try this on the "client" side though
> (with the dnsperf program which generates packets and then waits for the
> response)
> 
> With the 1.3.9 driver, I get a pretty consistent packet rate:
> 
> 1478599801.555815: 1346798.548250
> 1478599802.556818: 1345090.873854
> 1478599803.557820: 1348886.415811
> 1478599804.558826: 1347842.070877
> 1478599805.559823: 1346257.780992
> 1478599806.560821: 1347437.257617
> 1478599807.561818: 1346674.365657
> 1478599808.562824: 1351776.113230
> 1478599809.563818: 1347379.704574
> 
> I then unload the driver and install the new one:
> 
> # ifdown enp5s0f1
> Device 'enp5s0f1' successfully disconnected.
> # rmmod i40e
> # insmod ./i40e-1.3.38-4.3.5-300.fc23.ko
> # ifup enp5s0f1
> # ethtool -C enp5s0f1 adaptive-rx off adaptive-tx off
> 
> and re-running the test the packet rates are all over the place, and
> almost seem to be trending downwards over time:
> 
> 1478599891.282086: 1064831.565393
> 1478599892.282814: 1013365.270083
> 1478599893.283820: 958262.987435
> 1478599894.284814: 960207.553692
> 1478599895.285817: 947161.996517
> 1478599896.286852: 964507.734495
> 1478599897.287818: 991703.014888
> 1478599898.288815: 1010553.478182
> 1478599899.289822: 963053.205422
> 1478599900.290860: 933701.817513
> 1478599901.291816: 988006.465819
> 1478599902.292821: 957132.082257
> 1478599903.293822: 1017923.059018
> 1478599904.294820: 974373.575172
> 1478599905.295816: 947963.828027
> 1478599906.296817: 943062.993943
> 1478599907.297851: 885024.884270
> 1478599908.298818: 868948.726581
> 1478599909.299814: 945017.762309
> 1478599910.300846: 954253.210687
> 1478599911.301817: 936898.271778
> 1478599912.302818: 885917.196886
> 
> Even more bizarrely, the first time I ran this test it actually gave me
> the expected 1.35 Mpps for the first ten seconds or so before
> (gradually) dropping down to 1 Mpps or less.
> 
> More experimentation required - I'll do so with some reboots rather that
> rmmod / insmod.

Thanks for this info Ray.  This narrows it down a lot.  I'll be looking closely at the adaptive-itr mechanism for some improvements.  In the 1.3.38 version, it was not actually enabled.  The i40e hw's ITR feature is different than our other parts.  I wanted to confirm something though.  Are you still seeing variability in the non-adaptive ITR settings  on your client system?

Thanks again,

Carolyn

Carolyn Wyborny 
Linux Development 
Networking Division 
Intel Corporation 


