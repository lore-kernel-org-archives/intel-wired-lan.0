From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 22 Mar 2018 05:35:45 +0200
Subject: [Intel-wired-lan] e1000e Detected Hardware Unit Hang
In-Reply-To: <1317189213.22495.1521649183803@mail.libero.it>
References: <1969863829.1651192.1521629811656@mail.libero.it>
 <1317189213.22495.1521649183803@mail.libero.it>
Message-ID: <a97d11e0-6f94-e25c-4362-260073b07219@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 21/03/2018 18:19, Marco Berizzi wrote:
> Marco Berizzi wrote:
>>
>> Hello everyone,
>>
>> I'm getting this error with a Slackware linux 64bit running 4.16-rc6:
>> I have also done a full hardware replacement, but the problem is still
>> present. This box is running squid, named, sshd and strongswan.
>>
>> On february 3, I have replaced the network switch where this NIC is
>> connected to (from cisco 3750 to HPE 5130).
>> As you may see, the problem has popped up from Feb 13 with linux
>> 4.15.3, but yesterday the problem has arisen also with 4.15.2 (I
>> wanted to start a git bisect, but it is pointless).
> 
> I think I have found the root cause. Before getting this error the
> interface MTU was 9000bytes, and now it is 1500bytes.
Good. Please, try also disable TCP segmentation offload: ethtool -K 
<adapter> tso off. Keep us update.
>   
>> Any response are welcome.
>>
>> TIA
I've removed content due max message body 90K - message filtered.
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 

