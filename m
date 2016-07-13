From: John Fastabend <john.fastabend@gmail.com>
Date: Wed, 13 Jul 2016 10:44:51 -0700
Subject: [Intel-wired-lan] Configure traffic class to bringup DCB in
	back-to-back setup
In-Reply-To: <loom.20160713T110657-740@post.gmane.org>
References: <loom.20160713T110657-740@post.gmane.org>
Message-ID: <57867E13.3040708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16-07-13 02:09 AM, ayuj wrote:
> I just checked TLV's. Below are the details:
> 

OK so not really a netdev discussion seeing its just a user
space protocol setup issue. Going forward probably drop
netdev and add intel-wired-lan.

> OS :- CentOS 7.2
> kernel 3.10.0-327.el7.x86_64
> lldpad:- lldpad v0.9.46
> dcbtool:- v0.9.46
> ixgbe :- ixgbe-4.3.15
> 
> steps followed:- 
> 
> # modporbe ixgbe
> # service lldpad start 
>     Redirecting to /bin/systemctl start  lldpad.service
> 
> # service lldpad status
> Redirecting to /bin/systemctl status  lldpad.service
> ? lldpad.service - Link Layer Discovery Protocol Agent Daemon.
>    Loaded: loaded (/usr/lib/systemd/system/lldpad.service; disabled; vendor
> preset: disabled)
>    Active: active (running) since Tue 2016-07-05 05:49:12 EDT; 1s ago
>  Main PID: 133737 (lldpad)
>    CGroup: /system.slice/lldpad.service
>            ??133737 /usr/sbin/lldpad -t
> 
> Jul 05 05:49:12 localhost.localdomain systemd[1]: Started Link Layer
> Discovery Protocol Agent Daemon..
> Jul 05 05:49:12 localhost.localdomain systemd[1]: Starting Link Layer
> Discovery Protocol Agent Daemon....
> 
> lldptool -t -i p3p2 -n
> Chassis ID TLV
> 	MAC: 00:1b:21:bb:2e:da
> Port ID TLV
> 	MAC: 00:1b:21:bb:2e:da
> Time to Live TLV
> 	120
> IEEE 8021QAZ ETS Configuration TLV
> 	 Willing: yes
> 	 CBS: not supported
> 	 MAX_TCS: 8
> 	 PRIO_MAP: 0:0 1:0 2:0 3:0 4:0 5:0 6:0 7:0 
> 	 TC Bandwidth: 0% 0% 0% 0% 0% 0% 0% 0% 
> 	 TSA_MAP: 0:strict 1:strict 2:strict 3:strict 4:strict 5:strict 6:strict
> 7:strict 
> IEEE 8021QAZ PFC TLV
> 	 Willing: yes
> 	 MACsec Bypass Capable: no
> 	 PFC capable traffic classes: 8
> 	 PFC enabled: none
> End of LLDPDU TLV
> 
> Please help me in configuring traffic classes. I want to bringup DCB setup
> in a back-to-back senario.
> 

So at the moment it appears to be configured to use 802.1QAZ spec which
superseded the older spec even though lldpad supports both. Note the
tool itself really requires some spec knowledge to use correctly. The
spec to read is 802.1Q.

To configure it back-to-back (typical scenario is connected to a DCB
enabled switch where your administrator would setup the switch and this
would autoneg just fine) the servers need to be setup manually.

Perhaps reading if you haven't already the man page for lldptool and
lldptool-ets, lldptool-pfc would help. From the ets man page this
should kick things off,


#lldptool -T -i eth2 -V ETS-CFG \
          tsa=0:ets,1:ets,2:ets,3:ets,4:ets,5:ets,6:ets,7:ets \
          up2tc=0:0,1:1,2:2,3:3,4:4,5:5,6:6,7:7 \
          tcbw=12,12,12,12,13,13,13,13


#lldptool -T -i eth2 -V ETS-REC \
           tsa=0:ets,1:ets,2:ets,3:ets,4:ets,5:ets,6:ets,7:ets \
           up2tc=0:0,1:1,2:2,3:3,4:4,5:5,6:6,7:7 \
           tcbw=12,12,12,12,13,13,13,13

Thanks,
John


