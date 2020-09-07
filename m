From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Mon, 7 Sep 2020 14:45:08 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 3/6] xsk: introduce
 xsk_do_redirect_rx_full() helper
In-Reply-To: <dfa75afc-ceb7-76ce-6ba3-3b89c53f92f3@intel.com>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
 <20200904135332.60259-4-bjorn.topel@gmail.com>
 <20200904171143.5868999a@carbon>
 <dfa75afc-ceb7-76ce-6ba3-3b89c53f92f3@intel.com>
Message-ID: <20200907144508.3ddda938@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 4 Sep 2020 17:39:17 +0200
Bj?rn T?pel <bjorn.topel@intel.com> wrote:

> On 2020-09-04 17:11, Jesper Dangaard Brouer wrote:
> > On Fri,  4 Sep 2020 15:53:28 +0200 Bj?rn T?pel
> > <bjorn.topel@gmail.com> wrote:
> >   
> >> From: Bj?rn T?pel <bjorn.topel@intel.com>
> >> 
> >> The xsk_do_redirect_rx_full() helper can be used to check if a
> >> failure of xdp_do_redirect() was due to the AF_XDP socket had a
> >> full Rx ring.  
> > 
> > This is very AF_XDP specific.  I think that the cpumap could likely 
> > benefit from similar approach? e.g. if the cpumap kthread is
> > scheduled on the same CPU.
> >   
> 
> At least I thought this was *very* AF_XDP specific, since the kernel is
> dependent of that userland runs. Allocation (source) and Rx ring (sink).
> Maybe I was wrong! :-)
> 
> The thing with AF_XDP zero-copy, is that we sort of assume that if a
> user enabled that most packets will have XDP_REDIRECT to an AF_XDP socket.
> 
> 
> > But for cpumap we only want this behavior if sched on the same CPU
> > as RX-NAPI.  This could be "seen" by the cpumap code itself in the
> > case bq_flush_to_queue() drops packets, check if rcpu->cpu equal 
> > smp_processor_id().  Maybe I'm taking this too far?
> >   
> 
> Interesting. So, if you're running on the same core, and redirect fail
> for CPUMAP, you'd like to yield the NAPI loop? Is that really OK from a
> fairness perspective? I mean, with AF_XDP zero-copy we pretty much know
> that all actions will be redirect to socket. For CPUMAP type of
> applications, can that assumption be made?

Yes, you are right.  The RX NAPI loop could be doing something else,
and yielding the NAPI loop due to detecting same-CPU is stalling on
cpumap delivery might not be correct action.

I just tested the same-CPU processing case for cpumap (result below
signature), and it doesn't exhibit the bad 'dropping-off-edge'
performance slowdown.  The cpumap code also already tries to mitigate
this, by calling wake_up_process() for every 8 packets (CPU_MAP_BULK_SIZE).

I find your patchset very interesting, as I believe we do need some
kind of general push-back "flow-control" mechanism for XDP. Maybe I
should solve this differently in our XDP-TX-QoS pipe dream ;-)

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

Quick benchmark of cpumap.


Same CPU RX and cpumap processing:
----------------------------------

(Doing XDP_DROP on CPU)
Running XDP/eBPF prog_name:xdp_cpu_map0
XDP-cpumap      CPU:to  pps            drop-pps    extra-info
XDP-RX          4       9,189,700      0           0          
XDP-RX          total   9,189,700      0          
cpumap-enqueue    4:4   9,189,696      0           8.00       bulk-average
cpumap-enqueue  sum:4   9,189,696      0           8.00       bulk-average
cpumap_kthread  4       9,189,702      0           143,582    sched
cpumap_kthread  total   9,189,702      0           143,582    sched-sum
redirect_err    total   0              0          
xdp_exception   total   0              0          

2nd remote XDP/eBPF prog_name: xdp1
XDP-cpumap      CPU:to  xdp-pass       xdp-drop    xdp-redir
xdp-in-kthread  4       0              9,189,702   0         
xdp-in-kthread  total   0              9,189,702   0         

 %CPU
 51,8 ksoftirqd/4                       
 48,2 cpumap/4/map:17                   


(Doing XDP_PASS on CPU)
Running XDP/eBPF prog_name:xdp_cpu_map0
XDP-cpumap      CPU:to  pps            drop-pps    extra-info
XDP-RX          4       8,593,822      0           0          
XDP-RX          total   8,593,822      0          
cpumap-enqueue    4:4   8,593,888      7,714,949   8.00       bulk-average
cpumap-enqueue  sum:4   8,593,888      7,714,949   8.00       bulk-average
cpumap_kthread  4       878,930        0           13,732     sched
cpumap_kthread  total   878,930        0           13,732     sched-sum
redirect_err    total   0              0          
xdp_exception   total   0              0          

2nd remote XDP/eBPF prog_name: xdp_redirect_dummy
XDP-cpumap      CPU:to  xdp-pass       xdp-drop    xdp-redir
xdp-in-kthread  4       878,931        0           0         
xdp-in-kthread  total   878,931        0           0         



Another CPU getting cpumap redirected packets:
----------------------------------------------

(Doing XDP_DROP on CPU)
Running XDP/eBPF prog_name:xdp_cpu_map0
XDP-cpumap      CPU:to  pps            drop-pps    extra-info
XDP-RX          4       17,526,797     0           0          
XDP-RX          total   17,526,797     0          
cpumap-enqueue    4:0   17,526,796     245,811     8.00       bulk-average
cpumap-enqueue  sum:0   17,526,796     245,811     8.00       bulk-average
cpumap_kthread  0       17,281,001     0           16,351     sched
cpumap_kthread  total   17,281,001     0           16,351     sched-sum
redirect_err    total   0              0          
xdp_exception   total   0              0          

2nd remote XDP/eBPF prog_name: xdp1
XDP-cpumap      CPU:to  xdp-pass       xdp-drop    xdp-redir
xdp-in-kthread  0       0              17,281,001  0         
xdp-in-kthread  total   0              17,281,001  0         


(Doing XDP_PASS on CPU)
Running XDP/eBPF prog_name:xdp_cpu_map0
XDP-cpumap      CPU:to  pps            drop-pps    extra-info
XDP-RX          4       14,603,587     0           0          
XDP-RX          total   14,603,587     0          
cpumap-enqueue    4:0   14,603,582     12,999,248  8.00       bulk-average
cpumap-enqueue  sum:0   14,603,582     12,999,248  8.00       bulk-average
cpumap_kthread  0       1,604,338      0           0          
cpumap_kthread  total   1,604,338      0           0          
redirect_err    total   0              0          
xdp_exception   total   0              0          

2nd remote XDP/eBPF prog_name: xdp_redirect_dummy
XDP-cpumap      CPU:to  xdp-pass       xdp-drop    xdp-redir
xdp-in-kthread  0       1,604,338      0           0         
xdp-in-kthread  total   1,604,338      0           0         






