extends Node2D


func Fix():
	$CPUParticles2D.emitting = false
	$"Area2D/CollisionShape2D".disabled = true
func Break():
	$CPUParticles2D.emitting = true
	$"Area2D/CollisionShape2D".disabled = false
