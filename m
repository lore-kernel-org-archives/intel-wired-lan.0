From: Marco Berizzi <pupilla@libero.it>
Date: Fri, 23 Mar 2018 16:09:16 +0100 (CET)
Subject: [Intel-wired-lan] e1000e Detected Hardware Unit Hang
In-Reply-To: <1232121641.66220.1521715209616@mail.libero.it>
References: <1969863829.1651192.1521629811656@mail.libero.it>
 <1317189213.22495.1521649183803@mail.libero.it>
 <a97d11e0-6f94-e25c-4362-260073b07219@intel.com>
 <1232121641.66220.1521715209616@mail.libero.it>
Message-ID: <1104005455.161583.1521817756059@mail.libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Marco Berizzi wrote:
> 
> Neftin Sasha wrote:
> 
> > On 21/03/2018 18:19, Marco Berizzi wrote:
> > 
> > > Marco Berizzi wrote:
> > > >
> > > 
> > > > Hello everyone,
> > > > 
> > > > I'm getting this error with a Slackware linux 64bit running 4.16-rc6:
> > > > I have also done a full hardware replacement, but the problem is still
> > > > present. This box is running squid, named, sshd and strongswan.
> > > > 
> > > > On february 3, I have replaced the network switch where this NIC is
> > > > connected to (from cisco 3750 to HPE 5130).
> > > > As you may see, the problem has popped up from Feb 13 with linux
> > > > 4.15.3, but yesterday the problem has arisen also with 4.15.2 (I
> > > > wanted to start a git bisect, but it is pointless).
> > > 
> > > I think I have found the root cause. Before getting this error the
> > > interface MTU was 9000bytes, and now it is 1500bytes.
> > > Good. Please, try also disable TCP segmentation offload: ethtool -K
> > > 
> > > tso off. Keep us update.
> 
> Hi Sasha,
> 
> thanks for the quick response.
> I have disabled the tso:
> 
> ethtool -K eth2 tso off
> Cannot get device udp-fragmentation-offload settings: Operation not supported
> Cannot get device udp-fragmentation-offload settings: Operation not supported
> 
> I will keep you updated. Unfortunately I'm encountering this error
> message not more than once a day. So my response will be a little
> delayed.

Hi Sasha,

after more than 24 hours no error messages has popped up, so this is a
good workaround.

Question: is there a way to get the 82579LM working with the tso? Or is this
an hardware bug?
