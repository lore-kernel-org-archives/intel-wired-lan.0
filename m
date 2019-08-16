From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Thu, 15 Aug 2019 23:12:36 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 0/5] Add support for SKIP_BPF
 flag for AF_XDP sockets
In-Reply-To: <87ftm2wdzk.fsf@toke.dk>
References: <1565840783-8269-1-git-send-email-sridhar.samudrala@intel.com>
 <87ftm2adi2.fsf@toke.dk> <b9423054-247e-8b57-ea59-42368f60ea1e@intel.com>
 <87ftm2wdzk.fsf@toke.dk>
Message-ID: <3b85138e-97a7-e59c-194d-54301b482689@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 8/15/2019 10:11 AM, Toke H?iland-J?rgensen wrote:
> "Samudrala, Sridhar" <sridhar.samudrala@intel.com> writes:
> 
>> On 8/15/2019 4:12 AM, Toke H?iland-J?rgensen wrote:
>>> Sridhar Samudrala <sridhar.samudrala@intel.com> writes:
>>>
>>>> This patch series introduces XDP_SKIP_BPF flag that can be specified
>>>> during the bind() call of an AF_XDP socket to skip calling the BPF
>>>> program in the receive path and pass the buffer directly to the socket.
>>>>
>>>> When a single AF_XDP socket is associated with a queue and a HW
>>>> filter is used to redirect the packets and the app is interested in
>>>> receiving all the packets on that queue, we don't need an additional
>>>> BPF program to do further filtering or lookup/redirect to a socket.
>>>>
>>>> Here are some performance numbers collected on
>>>>     - 2 socket 28 core Intel(R) Xeon(R) Platinum 8180 CPU @ 2.50GHz
>>>>     - Intel 40Gb Ethernet NIC (i40e)
>>>>
>>>> All tests use 2 cores and the results are in Mpps.
>>>>
>>>> turbo on (default)
>>>> ---------------------------------------------	
>>>>                         no-skip-bpf    skip-bpf
>>>> ---------------------------------------------	
>>>> rxdrop zerocopy           21.9         38.5
>>>> l2fwd  zerocopy           17.0         20.5
>>>> rxdrop copy               11.1         13.3
>>>> l2fwd  copy                1.9          2.0
>>>>
>>>> no turbo :  echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
>>>> ---------------------------------------------	
>>>>                         no-skip-bpf    skip-bpf
>>>> ---------------------------------------------	
>>>> rxdrop zerocopy           15.4         29.0
>>>> l2fwd  zerocopy           11.8         18.2
>>>> rxdrop copy                8.2         10.5
>>>> l2fwd  copy                1.7          1.7
>>>> ---------------------------------------------
>>>
>>> You're getting this performance boost by adding more code in the fast
>>> path for every XDP program; so what's the performance impact of that for
>>> cases where we do run an eBPF program?
>>
>> The no-skip-bpf results are pretty close to what i see before the
>> patches are applied. As umem is cached in rx_ring for zerocopy the
>> overhead is much smaller compared to the copy scenario where i am
>> currently calling xdp_get_umem_from_qid().
> 
> I meant more for other XDP programs; what is the performance impact of
> XDP_DROP, for instance?

Will run xdp1 with and without the patches and include that data with 
the next revision.

