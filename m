From: Ruinskiy, Dima <dima.ruinskiy@intel.com>
Date: Wed, 1 Dec 2021 18:38:06 +0200
Subject: [Intel-wired-lan] [External] Re: [PATCH 3/3] Revert "e1000e:
 Add handshake with the CSME to support S0ix"
In-Reply-To: <3fad0b95-fe97-8c4a-3ca9-3ed2a9fa2134@lenovo.com>
References: <20211122161927.874291-1-kai.heng.feng@canonical.com>
 <20211122161927.874291-3-kai.heng.feng@canonical.com>
 <0ba36a30-95d3-a5f4-93c2-443cf2259756@intel.com>
 <3fad0b95-fe97-8c4a-3ca9-3ed2a9fa2134@lenovo.com>
Message-ID: <aa685a4f-c270-7b6e-1ede-24570d30dd98@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 30/11/2021 17:52, Mark Pearson wrote:
> Hi Sasha
> 
> On 2021-11-28 08:23, Sasha Neftin wrote:
>> On 11/22/2021 18:19, Kai-Heng Feng wrote:
>>> This reverts commit 3e55d231716ea361b1520b801c6778c4c48de102.
>>>
>>> Bugzilla:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=214821>>>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
> <snip>
>>>
>> Hello Kai-Heng,
>> I believe it is the wrong approach. Reverting this patch will put
>> corporate systems in an unpredictable state. SW will perform s0ix flow
>> independent to CSME. (The CSME firmware will continue run
>> independently.) LAN controller could be in an unknown state.
>> Please, afford us to continue to debug the problem (it is could be
>> incredible complexity)
>>
>> You always can skip the s0ix flow on problematic corporate systems by
>> using privilege flag: ethtool --set-priv-flags enp0s31f6 s0ix-enabled off
>>
>> Also, there is no impact on consumer systems.
>> Sasha
> 
> I know we've discussed this offline, and your team are working on the
> correct fix but I wanted to check based on your comments above that "it
> was complex". I thought, and maybe misunderstood, that it was going to
> be relatively simple to disable the change for older CPUs - which is the
> biggest problem caused by the patch.
> 
> Right now it's breaking networking for folk who happen to have a vPro
> Tigerlake (and I believe even potentially Cometlake or older) system. I
> think the impact of that could potentially be quite severe.
> 
> I understand not wanting to revert the change for the ADL platforms I
> believe this is targeting and to fix this instead - but your comment
> made me nervous that Linux users on older Intel based platforms are in
> for a long and painful wait - it is likely a lot of users....
> 
> Can you or Dima confirm the fix for older platforms will be available
> soon? I appreciate the ADL platform might take a bit more work and time
> to get right.
> 
> Thanks
> Mark
> 
Hi Mark,

What we currently see is that the issue manifests itself similarly on 
ADL and TGL platforms. Thus, the fix will likely be the same for both.

If we cannot find a proper fix soon, we will provide a workaround (for 
example by temporary disabling the feature on vPro platforms until we do 
have a fix).

This can be done without reverting the patch series, and I don't see 
much value in selectively disabling it for CML/TGL while leaving it on 
for ADL, unless our ongoing debug shows otherwise.

--Dima
