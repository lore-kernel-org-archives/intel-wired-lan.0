From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 31 Mar 2022 20:02:43 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: Fix incorrect locking in
 ice_vc_process_vf_msg()
In-Reply-To: <20220331174832.68e17c4a@ceranb>
References: <20220331105005.2580771-1-ivecera@redhat.com>
 <YkWpNVXYEBo/u3dm@boxer> <20220331174832.68e17c4a@ceranb>
Message-ID: <CO1PR11MB50891AEAC5604FD63BEB5C76D6E19@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Ivan Vecera <ivecera@redhat.com>
> Sent: Thursday, March 31, 2022 8:49 AM
> To: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Cc: netdev at vger.kernel.org; moderated list:INTEL ETHERNET DRIVERS <intel-
> wired-lan at lists.osuosl.org>; mschmidt <mschmidt@redhat.com>; Brett Creeley
> <brett.creeley@intel.com>; open list <linux-kernel@vger.kernel.org>; poros
> <poros@redhat.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: Re: [Intel-wired-lan] [PATCH net] ice: Fix incorrect locking in
> ice_vc_process_vf_msg()
> 
> On Thu, 31 Mar 2022 15:14:29 +0200
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:
> 
> > On Thu, Mar 31, 2022 at 12:50:04PM +0200, Ivan Vecera wrote:
> > > Usage of mutex_trylock() in ice_vc_process_vf_msg() is incorrect
> > > because message sent from VF is ignored and never processed.
> > >
> > > Use mutex_lock() instead to fix the issue. It is safe because this
> >
> > We need to know what is *the* issue in the first place.
> > Could you please provide more context what is being fixed to the readers
> > that don't have an access to bugzilla?
> >
> > Specifically, what is the case that ignoring a particular message when
> > mutex is already held is a broken behavior?
> 
> Reproducer:
> 
> <code>
> #!/bin/sh
> 
> set -xe
> 
> PF="ens7f0"
> VF="${PF}v0"
> 
> echo 1 > /sys/class/net/${PF}/device/sriov_numvfs
> sleep 2
> 
> ip link set ${VF} up
> ip addr add 172.30.29.11/24 dev ${VF}
> 
> while true; do
> 
> # Set VF to be trusted
> ip link set ${PF} vf 0 trust on
> 
> # Ping server again
> ping -c5 172.30.29.2 || {
>         echo Ping failed
>         ip link show dev ${VF} # <- No carrier here
>         break
> }
> 
> ip link set ${PF} vf 0 trust off
> sleep 1
> 
> done
> 
> echo 0 > /sys/class/net/${PF}/device/sriov_numvfs
> </code>
> 
> <sample>
> [root at wsfd-advnetlab150 ~]# uname -r
> 5.17.0+ # Current net.git HEAD
> [root at wsfd-advnetlab150 ~]# ./repro_simple.sh
> + PF=ens7f0
> + VF=ens7f0v0
> + echo 1
> + sleep 2
> + ip link set ens7f0v0 up
> + ip addr add 172.30.29.11/24 dev ens7f0v0
> + true
> + ip link set ens7f0 vf 0 trust on
> + ping -c5 172.30.29.2
> PING 172.30.29.2 (172.30.29.2) 56(84) bytes of data.
> 64 bytes from 172.30.29.2: icmp_seq=2 ttl=64 time=0.820 ms
> 64 bytes from 172.30.29.2: icmp_seq=3 ttl=64 time=0.142 ms
> 64 bytes from 172.30.29.2: icmp_seq=4 ttl=64 time=0.128 ms
> 64 bytes from 172.30.29.2: icmp_seq=5 ttl=64 time=0.129 ms
> 
> --- 172.30.29.2 ping statistics ---
> 5 packets transmitted, 4 received, 20% packet loss, time 4110ms
> rtt min/avg/max/mdev = 0.128/0.304/0.820/0.298 ms
> + ip link set ens7f0 vf 0 trust off
> + sleep 1
> + true
> + ip link set ens7f0 vf 0 trust on
> + ping -c5 172.30.29.2
> PING 172.30.29.2 (172.30.29.2) 56(84) bytes of data.
> From 172.30.29.11 icmp_seq=1 Destination Host Unreachable
> From 172.30.29.11 icmp_seq=2 Destination Host Unreachable
> From 172.30.29.11 icmp_seq=3 Destination Host Unreachable
> 
> --- 172.30.29.2 ping statistics ---
> 5 packets transmitted, 0 received, +3 errors, 100% packet loss, time 4125ms
> pipe 3
> + echo Ping failed
> Ping failed
> + ip link show dev ens7f0v0
> 20: ens7f0v0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq
> state DOWN mode DEFAULT group default qlen 1000
>     link/ether de:69:e3:a5:68:b6 brd ff:ff:ff:ff:ff:ff
>     altname enp202s0f0v0
> + break
> + echo 0
> 
> [root at wsfd-advnetlab150 ~]# dmesg | tail -8
> [  220.265891] iavf 0000:ca:01.0: Reset indication received from the PF
> [  220.272250] iavf 0000:ca:01.0: Scheduling reset task
> [  220.277217] iavf 0000:ca:01.0: Hardware reset detected
> [  220.292854] ice 0000:ca:00.0: VF 0 is now trusted
> [  220.295027] ice 0000:ca:00.0: VF 0 is being configured in another context that
> will trigger a VFR, so there is no need to handle this message
> [  234.445819] iavf 0000:ca:01.0: PF returned error -64 (IAVF_NOT_SUPPORTED)
> to our request 9
> [  234.466827] iavf 0000:ca:01.0: Failed to delete MAC filter, error
> IAVF_NOT_SUPPORTED
> [  234.474574] iavf 0000:ca:01.0: Remove device
> </sample>
> 
> User set VF to be trusted so .ndo_set_vf_trust (ice_set_vf_trust) is called.
> Function ice_set_vf_trust() takes vf->cfg_lock and calls ice_vc_reset_vf() that
> sends message to iavf that initiates reset task. During this reset task iavf sends
> config messages to ice. These messages are handled in ice_service_task() context
> via ice_clean_adminq_subtask() -> __ice_clean_ctrlq() ->
> ice_vc_process_vf_msg().

Right. Because the reset isn't finished in the PF by the time that the caller starts sending messages back.

I also think that this could be buggy if cfg_lock is held elsewhere too (though reset is the most likely problem).

Especially since the recent changes we did in ice to hold cfg_lock in more places to protect against concurrently configuring VFs. I think I agree with Ivans change (though perhaps we should re-test some cases for why we made this a try lock originally).

The only other concern was mentioned in a different message by Brett. Perhaps we also want to cancel any outstanding messages from the VF when we start a reset (since we're going to reset the VF and we don't really want to process any of its messages that were issued before the reset).

Thanks,
Jake

> 
> Function ice_vc_process_vf_msg() tries to take vf->cfg_lock but this can be locked
> from ice_set_vf_trust() yet (as in sample above). The lock attempt failed so the
> function
> returns, message is not processed.
> 
> Thanks,
> Ivan

