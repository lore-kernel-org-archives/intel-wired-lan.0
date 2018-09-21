From: Song Liu <songliubraving@fb.com>
Date: Fri, 21 Sep 2018 07:17:03 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe: check return value of
 napi_complete_done()
In-Reply-To: <028b4cea-0e3f-fab5-7a74-cf003bbd1134@gmail.com>
References: <20180920190113.490005-1-songliubraving@fb.com>
 <c1251d5d-4b18-a1de-acd2-6de829b7c7ac@gmail.com>
 <2ca0e823642d232092017f66e8151652e22e74a1.camel@intel.com>
 <0DAF1AF9-E98D-4D0F-BD68-F5936A0312C6@fb.com>
 <ee9b9a55-c967-cec3-7df1-79f84b06154c@gmail.com>
 <E4A7BD0D-B091-4FBD-94A9-F0104729DCF6@fb.com>
 <028b4cea-0e3f-fab5-7a74-cf003bbd1134@gmail.com>
Message-ID: <ACD41205-3FDD-4FD2-BF36-897DD98D63EC@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> On Sep 20, 2018, at 4:49 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> 
> 
> 
> On 09/20/2018 04:43 PM, Song Liu wrote:
>> 
> 
>> I tried to totally skip ndo_poll_controller() here. It did avoid hitting
>> the issue. However, netpoll will drop (fail to send) more packets. 
>> 
> 
> Why is it failing ?
> 
> If you are under high memory pressure, then maybe if you absolutely want memory to send
> netpoll packets, you want to grab all NAPI contexts as a way to prevent other cpus 
> from feeding incoming packets to the host and add more memory pressure ;)
> 

I did the test with Eric's latest patch (and disable ndo_poll_controller 
in driver). The result didn't show significant increase in drop packets. 
I guess packet drops in my earlier test was caused by some other changes
I mixed there. 

So I think this patch does fix the issue. Thanks Eric!

For ixgbe, I think we need to check napi_complete_done() return value
anyway. Otherwise, the driver will enable IRQ in polling mode.  

Song
